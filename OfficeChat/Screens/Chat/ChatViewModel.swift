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
    
    let db = Firestore.firestore()
    var reference: CollectionReference?
    
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
        reference = db.collection(["channels", id, "thread"].joined(separator:"/"))
        
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
        reference?.addDocument(data: message.representation) { error in
            if error != nil {
                return
            }
        }
    }
    
    func downloadImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        ref.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }

    func handleDocumentChange(_ change: DocumentChangeProtocol) {
        guard var message = Message(document: change.data) else { return }
        switch change.type {
        case .added:
            if let url = message.downloadURL {
                downloadImage(at: url) { [weak self] image in
                    guard
                        let self = self,
                        let image = image
                    else { return }
                    
                    message.image = image
                    self.insertNewMessage(message)
                }
            } else {
                insertNewMessage(message)
            }
        default:
            break
        }
    }
    
    func uploadImage(_ image: UIImage, to channel: Channel, completion: @escaping (URL?) -> Void) {
        guard let channelID = channel.id else {
            completion(nil)
            return
        }
        
        guard let scaledImage = image.scaledToSafeUploadSize,
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
            guard let `self` = self else {
                return
            }
            self.uploadingImage = false
            
            guard let url = url else {
                return
            }
            
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
