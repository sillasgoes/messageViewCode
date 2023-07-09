//
//  ContactController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 07/07/23.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContactProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func successContact()
}

class ContactController {
    
    weak var delegate: ContactProtocol?
    
    public func delegate(delegate: ContactProtocol) {
        self.delegate = delegate
    }
    
    func addContact(email: String, emailUserLogged: String, idUser: String) {
        
        guard email != emailUserLogged else {
            delegate?.alertStateError(title: "Você digitou seu próprio Email", message: "Adicione um email diferente")
            return
        }
        
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResult, error in
            
            if let totalItems = snapshotResult?.count {
                if totalItems == 0 {
                    self.delegate?.alertStateError(title: "Usuário não cadastrado", message: "Verifique o email e tente novamente")
                    return
                }
            }
            
            if let snapshot = snapshotResult{
                for document in snapshot.documents {
                    let dados = document.data()
                    self.saveContact(dataContact: dados, idUser: idUser)
                }
            }
        }
    }
    
    func saveContact(dataContact: Dictionary<String, Any>, idUser: String) {
        let contact = Contact(dictonary: dataContact)
        let firestore = Firestore.firestore()
        
        firestore.collection("usuarios")
            .document(idUser)
            .collection("contatos")
            .document(contact.id ?? "").setData(dataContact) { error in
                if error == nil {
                    self.delegate?.successContact()
                }
            }
    }
}
