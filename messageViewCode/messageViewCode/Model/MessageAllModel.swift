//
//  MessageAllModel.swift
//  messageViewCode
//
//  Created by Sillas Santos on 07/07/23.
//

import Foundation

class Message {
    var texto: String?
    var idUser: String?
    
    init(dictonary: [String: Any]) {
        texto = dictonary["texto"] as? String
        idUser = dictonary["idUsuario"] as? String
    }
}

class Conversation {
    var nome: String?
    var lastMessage: String?
    var idRecipient: String?
    
    init(dictonary: [String: Any]) {
        nome = dictonary["nomeUsuario"] as? String
        lastMessage = dictonary["ultimaMensagem"] as? String
        idRecipient = dictonary["idDestinatario"] as? String
    }
}

class User {
    var nome: String?
    var email: String?
    
    init(dictonary: [String: Any]) {
        nome = dictonary["nome"] as? String
        email = dictonary["email"] as? String
    }
}

class Contact {
    var id: String?
    var nome: String?
    
    init(dictonary: [String: Any]?) {
        id = dictonary?["id"] as? String
        nome = dictonary?["nome"] as? String
    }
    
    convenience init(id: String?, nome: String?) {
        self.init(dictonary: nil)
        self.id = id
        self.nome = nome
    }
}
