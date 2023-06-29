//
//  ViewController.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 11/06/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var loginScreen: LoginScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.configTextFieldDelegate(delegate: self)
        loginScreen?.delegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: LoginScreenProtocol {
    
    func actionLoginButton(_ action: TypeAction) {
//        if action == .success {
//
//            guard let loginScreen = loginScreen else { return }
//
//            auth?.signIn(withEmail: loginScreen.getEmail(), password: loginScreen.getPassword()) { result, error in
//
//                guard let result = result else {
//                    self.alert?.getAlert(title: "Atenção", message: "Dados incorretos, verique e tente novamente")
//                    return
//                }
//
//                print("Resultado do login \(result.description)")
//
//            }
//
//        } else {
//            let alert = UIAlertController(title: "Atenção", message: "Preencha os dois campos", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            present(alert, animated: true)
//        }
    }
    
    func actionRegisterButton() {
        let vc: RegisterViewController = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
