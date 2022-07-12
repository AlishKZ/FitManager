//
//  ChatViewController.swift
//  FitnessManager
//
//  Created by Алишер Ахметжанов on 18.05.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message {
    var id: String
    var content: String
    var senderID: String
    var senderName: String
    var dictionary: [String: Any] {
        return [
            "id": id,
            "content": content,
            "senderID": senderID,
            "senderName":senderName]
    }
}

extension Message {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let content = dictionary["content"] as? String,
              let senderID = dictionary["senderID"] as? String,
              let senderName = dictionary["senderName"] as? String
        else {return nil}
        self.init(id: id, content: content, senderID: senderID, senderName:senderName)
    }
}

extension Message: MessageType {
    
    var sender: SenderType {
        return Sender(senderId: senderID, displayName: senderName)
    }
    var messageId: String {
        return id
    }
    var sentDate: Date {
        return Date()
    }
    var kind: MessageKind {
        return .text(content)
    }
}

class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "ME")
    let otherUser = Sender(senderId: "other", displayName: "Neo")

    var messages = [MessageType]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToLastItemOnKeyboardBeginsEditing = true

        messageInputBar.inputTextView.tintColor = .systemBlue
        messageInputBar.sendButton.setTitleColor(.systemTeal, for: .normal)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    private func insertNewMessage(_ message: Message) {
            
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(id: "", content: text, senderID: currentUser.senderId, senderName: currentUser.displayName)
        
            insertNewMessage(message)
        
            inputBar.inputTextView.text = ""
            messagesCollectionView.reloadData()
            messagesCollectionView.scrollToLastItem(animated: true)
    }

    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return  messages.count
    }
    
    //MARK: - хелперс configurate
    func configureUI() {
        view.backgroundColor = .fitGrey
        navigationItem.title = "Chat"
    }
}

