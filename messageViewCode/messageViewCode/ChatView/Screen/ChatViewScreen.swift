//
//  ChatViewScreen.swift
//  messageViewCode
//
//  Created by Sillas Santos on 09/07/23.
//

import UIKit
import Foundation

protocol ChatViewScreenProtocol: AnyObject {
    func actionPushMessage()
}

class ChatViewScreen: UIView {
    
    weak private var delegate: ChatViewScreenProtocol?
    
    public func delegate(delegate: ChatViewScreenProtocol) {
        self.delegate = delegate
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var navView: ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = CustomColor.appPink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = CustomColor.appPink.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(self.sendBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        return btn
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite aqui"
        tf.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        table.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        table.backgroundColor = .white
        table.transform = CGAffineTransform(scaleX: 1, y: -1)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    
    public func configTableView(delegate:UITableViewDelegate,dataSource:UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func configNavView(controller:ChatViewController){
        self.navView.controller = controller
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        bottomConstraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        addConstraint(bottomConstraint ?? NSLayoutConstraint())
        sendBtn.isEnabled = false
        sendBtn.layer.opacity = 0.4
        sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        inputMessageTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        addSubview(tableView)
        addSubview(navView)
        addSubview(messageInputView)
        messageInputView.addSubview(messageBar)
        messageBar.addSubview(sendBtn)
        messageBar.addSubview(inputMessageTextField)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: self.topAnchor),
            navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor,constant: -20),
            messageBar.heightAnchor.constraint(equalToConstant: 55),
            messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            sendBtn.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            sendBtn.heightAnchor.constraint(equalToConstant: 55),
            sendBtn.widthAnchor.constraint(equalToConstant: 55),
            sendBtn.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            
            inputMessageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor,constant: 20),
            inputMessageTextField.trailingAnchor.constraint(equalTo: self.sendBtn.leadingAnchor,constant: -5),
            inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor)
        ])
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight
            
            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.layoutIfNeeded()
            } , completion: {(completed) in
                // CFG
            })
        }
    }
    
    @objc func sendBtnPressed() {
        self.sendBtn.touchAnimation(s: self.sendBtn)
        self.delegate?.actionPushMessage()
        self.startPushMessage()
    }
    
    public func startPushMessage() {
        self.inputMessageTextField.text = ""
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
    }
}

extension ChatViewScreen: UITextFieldDelegate {
    
    //MARK: Animating
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = false
                self.sendBtn.layer.opacity = 0.4
                self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = true
                self.sendBtn.layer.opacity = 1
                self.sendBtn.transform = .identity
            }, completion: { _ in
            })
        }
    }
    
}

