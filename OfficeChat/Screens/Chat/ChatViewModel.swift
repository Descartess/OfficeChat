//
//  ChatViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ChatViewModel {
    
    var db: DatabaseManagerProtocol {
        return AppEnvironment.current.databaseManager
    }
    
    var reference: CollectionReferenceProtocol?
    
    var messages = [Message]()
    var messageListener: ListenerRegistration?
    weak var delegate: ChatViewDelegate?
    
    var user: UserProtocol
    var channel: Channel
    
    let storage = Storage.storage().reference()
    
    var uploadingImage = false {
        didSet {
            delegate?.isUploadingPhoto()
        }
    }
    
    init?(user: UserProtocol, channel: Channel) {
        self.user = user
        self.channel = channel
        guard let id = channel.id else {
            return nil
        }
        reference = db.collectionReference(["channels", id, "thread"].joined(separator:"/"))
        
        messageListener = reference?.addSnapshotListener { querySnapshot, _ in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    func insertNewMessage(_ message: Message) {
        guard !messages.contains(message) else { return }
        messages.append(message)
        messages.sort()
        delegate?.insertNewMessage(message)
    }
    
    func save(_ message: Message) {
        reference?.addDocumentRef(data: message.representation, completion: nil)
    }

    func handleDocumentChange(_ change: DocumentChangeProtocol) {
        guard let message = Message(document: change.data) else { return }
        switch change.type {
        case .added:
            insertNewMessage(message)
        default:
            break
        }
    }
    
    func uploadImage(_ image: UIImage, to channel: Channel, completion: @escaping (URL?) -> Void) {
        guard
            let channelID = channel.id,
            let scaledImage = image.scaledToSafeUploadSize,
            let data = scaledImage.jpegData(compressionQuality: 0.4) else {
                completion(nil)
                return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        
        let imageRef = storage.child(channelID).child(imageName)
            
        imageRef.putData(data, metadata: metadata) { _, _ in
            imageRef.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
    func sendPhoto(_ image: UIImage) {
        uploadingImage = true
        
        uploadImage(image, to: channel) { [weak self] url in
            guard
                let `self` = self,
                let url = url else {
                return
            }
            self.uploadingImage = false
            
            var message = Message(user: self.user, image: image)
            message.downloadURL = url
            
            self.save(message)
            self.delegate?.didSaveMessage()
        }
    }

    deinit {
        messageListener?.remove()
    }
}
