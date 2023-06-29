//
//  RegisterViewController.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 19/06/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var registerScreen: RegisterScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.configTextFieldDelegate(delegate: self)
        registerScreen?.delegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: RegisterScreenProtocol {
    
    func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton(_ type: typeAction) {
        if type == .success {
            
            guard let registerScreen = registerScreen else { return }

            auth?.createUser(withEmail: registerScreen.getEmail(), password: registerScreen.getPassword()) { result, error in
                guard let result = result else  {
                    self.alert?.getAlert(title: "Atenção", message: "Digite novamente email e senha")
                    return
                }
                
                self.alert?.getAlert(title: "Sucesso", message: "Registro efetuado com sucesso") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Os dois campos devem ser preenchidos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
