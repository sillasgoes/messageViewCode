//
//  NavView.swift
//  messageViewCode
//
//  Created by Sillas Santos on 30/06/23.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavViewProtocol: AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}

class NavView: UIView {
    
    weak private var delegate: NavViewProtocol?
    
    func delegate(delegate: NavViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
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
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
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
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    lazy var conversationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(tappedConversation), for: .touchUpInside)
        return button
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "message"), for: .normal)
        button.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedConversation() {
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
        self.delegate?.typeScreenMessage(type: .conversation)
    }
    
    @objc func tappedContactButton() {
        self.conversationButton.tintColor = .black
        self.contactButton.tintColor = .systemPink
        self.delegate?.typeScreenMessage(type: .contact)
    }
    
    func addSubView() {
        addSubview(backgroundView)
        addSubview(navBar)
        addSubview(searchBar)
        addSubview(searchLabel)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
}
