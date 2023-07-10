//
//  ChatViewController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 09/07/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var screen: ChatViewScreen?
    var contact: Contact?
    
    override func loadView() {
        screen = ChatViewScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
