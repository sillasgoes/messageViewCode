//
//  ChatViewController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 09/07/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var listMessages: [Message] = []
    var idUserLogged: String?
    var contact: Contact?
    var messagesListener: ListenerRegistration?
    var auth: Auth?
    var db: Firestore?
    var nameContact: String?
    var nameUserLogged: String?
    
    var screen: ChatViewScreen?
    
    override func loadView() {
        screen = ChatViewScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configDataFirebase()
        configChatView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addListenerRecuperarMensagens()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.messagesListener?.remove()
    }
    
    func addListenerRecuperarMensagens(){
        
        if let idRecipient = self.contact?.id{
            
            messagesListener = db?.collection("mensagens").document(self.idUserLogged ?? "").collection(idRecipient).order(by: "data", descending: true).addSnapshotListener({ querySnapshot, error in
                
                //limpar lista
                self.listMessages.removeAll()
                
                //Recuperar dados
                if let snapshot = querySnapshot{
                    for document in snapshot.documents{
                        let data = document.data()
                        self.listMessages.append(Message(dictonary: data))
                    }
                    self.screen?.reloadTableView()
                }
            })
        }
    }
    
    private func configDataFirebase(){
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //Recuperar Id Usuario Logado
        if let id = self.auth?.currentUser?.uid{
            self.idUserLogged = id
            self.recoverDataUserLogged()
        }
        
        if let name = self.contact?.nome{
            self.nameContact = name
        }
    }
    
    private func recoverDataUserLogged(){
        let users = self.db?.collection("usuarios").document(self.idUserLogged ?? "")
        users?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let dados: Contact = Contact(dictonary: documentSnapshot?.data() ?? [:])
                self.nameUserLogged = dados.nome ?? ""
            }
        })
    }
    
    private func configChatView(){
        screen?.configNavView(controller: self)
        screen?.configTableView(delegate: self, dataSource: self)
        screen?.delegate(delegate: self)
    }
    
    @objc func tappedBackButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveMessage(idRemetente: String, idDestinatario: String, mensagem:[String:Any]){
        db?.collection("mensagens").document(idRemetente).collection(idDestinatario).addDocument(data: mensagem)
        screen?.inputMessageTextField.text = ""
    }
    
    private func salvarConversa(idRemetente: String, idDestinatario: String, conversa: [String:Any]){
        db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)
    }
}

extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indice = indexPath.row
        let data = self.listMessages[indice]
        let idUser = data.idUser ?? ""
        
        
        if self.idUserLogged != idUser{
            //LADO ESQUERDO
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: data)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }else{
            //LADO DIREITO
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: data)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc: String = self.listMessages[indexPath.row].texto ?? ""
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
        let estimateHeight = desc.heightWithConstrainedWidth(width: 220, font: font)
        return CGFloat(65 + estimateHeight)
    }

}

extension ChatViewController: ChatViewScreenProtocol{
    
    func actionPushMessage() {
        
        let message: String = self.screen?.inputMessageTextField.text ?? ""
        
        if let idUserRecipient = contact?.id{
            
            let mensagem:Dictionary<String,Any> = [
                "idUsuario" : self.idUserLogged ?? "",
                "texto" : message,
                "data" : FieldValue.serverTimestamp()
            ]
            
            //mensagem para remetente
            self.saveMessage(idRemetente: self.idUserLogged ?? "", idDestinatario: idUserRecipient, mensagem: mensagem)
            
            //salvar mensagem para destinario
            self.saveMessage(idRemetente: idUserRecipient, idDestinatario: self.idUserLogged ?? "", mensagem: mensagem)
            
            var conversation:Dictionary<String,Any> = [
                "ultimaMensagem" : message
            ]
            
            //salvar conversa para remetente(dados de quem recebe)
            conversation["idRemetente"] = idUserLogged ?? ""
            conversation["idDestinatario"] = idUserRecipient
            conversation["nomeUsuario"] = self.nameContact ?? ""
            self.salvarConversa(idRemetente: idUserLogged ?? "", idDestinatario: idUserRecipient, conversa: conversation)
            
            //salvar conversa para destinatario(dados de quem envia)
            conversation["idRemetente"] = idUserRecipient
            conversation["idDestinatario"] = idUserLogged ?? ""
            conversation["nomeUsuario"] = self.nameUserLogged ?? ""
            self.salvarConversa(idRemetente: idUserRecipient, idDestinatario: idUserLogged ?? "", conversa: conversation)
            
        }
    }
}
