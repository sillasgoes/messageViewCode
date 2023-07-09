//
//  MessageLastCollectionViewCell.swift
//  messageViewCode
//
//  Created by Sillas Santos on 07/07/23.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    
   static let identifier = "MessageLastCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(systemName: "person.badge.plus")
        return image
    }()
    
    lazy var addNewContactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicionar novo contato"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(addNewContactLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            addNewContactLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            addNewContactLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            addNewContactLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
