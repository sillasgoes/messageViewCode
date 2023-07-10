//
//  OutgoingTextMessageTableViewCell.swift
//  messageViewCode
//
//  Created by Sillas on 10/07/2023.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {

    static let identifier:String = "OutgoingTextMessageTableViewCell"
    
    lazy var myMessageView: UIView = {
       let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = CustomColor.appPurple
        bv.layer.cornerRadius = 20
        bv.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return bv
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElemented()
        setupContraints()
    }
    
    func addElemented(){
        addSubview(self.myMessageView)
        myMessageView.addSubview(self.messageTextLabel)
        isSelected = false
    }
    
    func setupContraints(){
        
        NSLayoutConstraint.activate([
            myMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            myMessageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: self.myMessageView.leadingAnchor,constant: 15),
            messageTextLabel.topAnchor.constraint(equalTo: self.myMessageView.topAnchor,constant: 15),
            messageTextLabel.bottomAnchor.constraint(equalTo: self.myMessageView.bottomAnchor,constant: -15),
            messageTextLabel.trailingAnchor.constraint(equalTo: self.myMessageView.trailingAnchor,constant: -15),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message:Message?){
        self.messageTextLabel.text = message?.texto ?? ""
    }

}
