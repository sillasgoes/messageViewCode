//
//  IncomingTextMessageTableViewCell.swift
//  messageViewCode
//
//  Created by Sillas on 10/07/2023.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier: String = "IncomingTextMessageTableViewCell"
    
    lazy var contactMessage: UIView = {
       let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(white: 0, alpha: 0.06)
        bv.layer.cornerRadius = 20
        bv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return bv
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElemented()
        setupContraints()
    }
    
    func addElemented() {
        addSubview(self.contactMessage)
        contactMessage.addSubview(self.messageTextLabel)
        isSelected = false
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            contactMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            contactMessage.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: self.contactMessage.leadingAnchor,constant: 15),
            messageTextLabel.topAnchor.constraint(equalTo: self.contactMessage.topAnchor,constant: 15),
            messageTextLabel.bottomAnchor.constraint(equalTo: self.contactMessage.bottomAnchor,constant: -15),
            messageTextLabel.trailingAnchor.constraint(equalTo: self.contactMessage.trailingAnchor,constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message: Message?){
        self.messageTextLabel.text = message?.texto ?? ""
    }
    
}
