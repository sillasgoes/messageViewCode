//
//  HomeViewController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 30/06/23.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUserLogged: String?
    var emailUserLogged: String?
    var screenContact: Bool?
    var alert: Alert?
    var screen: HomeScren?
    
    var contact: ContactController?
    var listContact: [Contact] = []
    var listConvesation: [Conversation] = []
    var conversationListener: ListenerRegistration?
    
    
    override func loadView() {
        let screen = HomeScren()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
        configHomeView()
        configCollectionView()
        configAlert()
        configIdentifierFirebase()
        configContact()
    }
    
    private func configHomeView() {
        screen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        screen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        auth = Auth.auth()
        db = Firestore.firestore()
        
        if let currentUser = auth?.currentUser {
            self.idUserLogged = currentUser.uid
            self.emailUserLogged = currentUser.email
        }
    }
    
    private func configContact() {
        self.contact = ContactController()
        contact?.delegate = self
    }
    
    func addListenerRecoverConversations() {
        
        guard let idUserLogged = auth?.currentUser?.uid else { return }
        
        conversationListener = db?.collection("conversas").document(idUserLogged).collection("ultimas_conversas").addSnapshotListener({ querySnapshot, error in
            
            if error == nil {
                self.listConvesation.removeAll()
                
                if let snapshot = querySnapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        self.listConvesation.append(Conversation(dictonary: data))
                    }
                }
                
                self.screen?.reloadCollectionView()
            }
        })
    }
    
    func getContact() {
        listContact.removeAll()
        db?.collection("usuarios")
            .document(idUserLogged ?? "")
            .collection("contatos")
            .getDocuments(completion: { snapshotResult, error in
                
                if error != nil {
                    print("Error get contact")
                    return
                }
                
                if let snapshot = snapshotResult {
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.listContact.append(Contact(dictonary: dados))
                        
                        self.screen?.reloadCollectionView()
                    }
                }
            })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: CGRect.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeViewController: NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            screenContact = true
            getContact()
        case .conversation:
            screenContact = false
            // Recuperar conversas
            self.screen?.reloadCollectionView()
        }
    }
}

extension HomeViewController: ContactProtocol {
    
    func alertStateError(title: String, message: String) {
        alert?.getAlert(title: title, message: message)
    }
    
    func successContact() {
        alert?.getAlert(title: "Success", message: "Save contact with success") {
            print("Success")
        }
    }
}
