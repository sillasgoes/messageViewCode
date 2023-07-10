//
//  ChatNavigationView.swift
//  messageViewCode
//
//  Created by Sillas Santos on 09/07/23.
//

import UIKit

class ChatNavigationView: UIView {
    
    var controller: ChatViewController? {
        didSet {
            backButton.addTarget(self, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
        }
    }

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = CustomColor.appLight
        return view
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite Aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    lazy var customImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.image = UIImage(named: "imagem-perfil")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        addSubview(backgroundView)
        backgroundView.addSubview(navBar)
        navBar.addSubview(backButton)
        navBar.addSubview(customImage)
        navBar.addSubview(searchBar)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchButton)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
                self.backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
                self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                
                self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                
                self.backButton.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
                self.backButton.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
                self.backButton.heightAnchor.constraint(equalToConstant: 30),
                self.backButton.widthAnchor.constraint(equalToConstant: 30),
                
                self.customImage.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 20),
                self.customImage.heightAnchor.constraint(equalToConstant: 55),
                self.customImage.widthAnchor.constraint(equalToConstant: 55),
                self.customImage.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
                
                self.searchBar.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 20),
                self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
                self.searchBar.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -20),
                self.searchBar.heightAnchor.constraint(equalToConstant: 55),
                
                self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor,constant: 25),
                self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
                
                self.searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor,constant: -20),
                self.searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
                self.searchButton.heightAnchor.constraint(equalToConstant: 20),
                self.searchButton.widthAnchor.constraint(equalToConstant: 20)
            ])
    }
}
