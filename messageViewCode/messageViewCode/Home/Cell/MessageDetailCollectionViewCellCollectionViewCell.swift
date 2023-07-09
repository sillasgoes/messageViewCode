//
//  MessageDetailCollectionViewCellCollectionViewCell.swift
//  messageViewCode
//
//  Created by Sillas Santos on 07/07/23.
//

import UIKit

class MessageDetailCollectionViewCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MessageDetailCollectionViewCellCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.image = UIImage(systemName: "image-perfil")
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(userName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Errror")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setupViewContact(contact: Contact) {
        setUserName(userName: contact.nome ?? "")
    }
    
    func setupViewConversation(conversation: Conversation) {
        setAttributedText(conversation)
    }
    
    private func setAttributedText(_ conversation: Conversation) {
        
        func setUserNameAttributedText(_ conversatioh: Conversation){
            let attributedText = NSMutableAttributedString(string:"\(conversation.nome ?? "")",
                                                           attributes:
                                                            [NSAttributedString.Key.font:
                                                                            UIFont(name : CustomFont.poppinsMedium, size: 16) ?? UIFont (), NSAttributedString.Key.foregroundColor: UIColor .darkGray])
            attributedText.append(
                NSAttributedString(string: "\n\(conversation.lastMessage ?? "")",
                                   attributes: [NSAttributedString.Key.font: UIFont(name :CustomFont.poppinsMedium, size: 14) ?? UIFont (),
                                                                                                                                                                                                                                                    NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            self.userName.attributedText = attributedText
        }
    }
    
    private func setUserName(userName: String) {
        let text = NSAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        
        self.userName.attributedText = text
    }
    
}
