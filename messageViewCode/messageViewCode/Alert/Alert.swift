//
//  Alert.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 27/06/23.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, _ completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        alertController.addAction(cancelar)
        controller?.present(alertController, animated: true, completion: nil)
    }
    
    func addContact(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Adicionar Usuario", message: "Digite uma email Valido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Adicionar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        controller?.present(alert, animated: true, completion: nil)
    }
}
