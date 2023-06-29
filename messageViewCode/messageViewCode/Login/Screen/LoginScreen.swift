//
//  ViewControllerView.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 12/06/23.
//

import UIKit

// MARK: - Enum

enum TypeAction {
    case success
    case failure
}

// MARK: - Protocol

protocol LoginScreenProtocol: AnyObject {
    func actionLoginButton(_ action: TypeAction)
    func actionRegisterButton()
}

class LoginScreen: UIView {
    
    // MARK: - Delegate
    private weak var delegate: LoginScreenProtocol?
    
    func delegate(delegate: LoginScreenProtocol) {
        self.delegate = delegate
    }
    
    // MARK: - Proprieties
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Login"
        return label
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .red
        image.image = UIImage(named: "whats")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 7.5
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu email"
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 7.5
        tf.layer.borderWidth = 1
        tf.layer.position = .init(x: 4, y: 10)
        tf.keyboardType = .default
        tf.placeholder = "Digite sua senha"
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta? Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(loginLabel)
        addSubview(logoAppImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    @objc func tappedLoginButton() {
        guard Utils.Email.validate(email: emailTextField.text, password: passwordTextField.text) else {
            delegate?.actionLoginButton(.failure)
            return
        }
        
        delegate?.actionLoginButton(.success)
    }
    
    @objc func tappedRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    // MARK: - SnapKit funcs
    
    func configConstraints() {
        configLoginLabelConstraint()
        configLogoAppImageViewConstraint()
        configEmailTextFieldConstraint()
        configPasswordTextFieldConstraint()
        configLoginButtonConstraint()
        configRegisterButtonConstraint()
    }
    
    func configLoginLabelConstraint() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configLogoAppImageViewConstraint() {
        logoAppImageView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
            make.height.equalTo(45)
        }
    }
    
    func configEmailTextFieldConstraint() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoAppImageView.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    func configPasswordTextFieldConstraint() {
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    func configLoginButtonConstraint() {
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
    
    func configRegisterButtonConstraint() {
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.leading.equalTo(loginButton.snp.leading)
            make.trailing.equalTo(loginButton.snp.trailing)
            make.height.equalTo(loginButton.snp.height)
        }
    }
}
