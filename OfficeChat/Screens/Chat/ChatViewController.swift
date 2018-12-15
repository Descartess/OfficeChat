//
//  ChatViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import UIKit
import Foundation
import MessageKit
import MessageInputBar

class ChatViewController: MessagesViewController {
    
    var viewModel: ChatViewModel? {
         didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
    } 
    
    func bindViewModel() {
        guard let vm = viewModel else {
            return
        }
        title = vm.channel.name
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> Sender {
        guard let vm = viewModel else {
            return Sender(id: "", displayName: "")
        }
        return Sender(id: vm.user.uid, displayName: vm.user.displayName ?? "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return viewModel!.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.messages.count
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func avatarSize(for message: MessageType,
                    at indexPath: IndexPath,
                    in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType,
                         at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType,
                             at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType,
                      at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}

extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        guard let vm = viewModel
            else { return }
        let message = Message(user: vm.user, content: text)
        vm.save(message)
        inputBar.inputTextView.text = ""
    }
}

extension ChatViewController: UIImagePickerControllerDelegate {
    
}

extension ChatViewController: ChatViewDelegate {
    func didSaveMessage() {
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    func insertNewMessage(_ message: Message) {
        guard let vm = viewModel else { return }
        
        let isLatestMessage = vm.messages.index(of: message) == (vm.messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
        
        messagesCollectionView.reloadData()
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
}
