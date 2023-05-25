//
//  SignInViewController.swift
//  TIKTOK
//
//  Created by Apple on 15/05/2023.
//

import UIKit

import UIKit

class SiginViewController: UIViewController {
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType  = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
         return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType  = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
         return field
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        
       return button
    }()
    
    private let entryLabel:UILabel = {
        let label = UILabel()
        
        label.text = "if you dont have Account you can still go in click here"
        label.textAlignment = .left
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)

        label.attributedText = attributedString
        return label
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Sign in"
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(entryLabel)
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(loginButton)
        configure()
        loginButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        navBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        entryLabel.isUserInteractionEnabled = true
        entryLabel.addGestureRecognizer(tapGesture)
    }
    
    
    
  private  func configure() {
     
        NSLayoutConstraint.activate([
            entryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            entryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            entryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Set emailField constraints
        NSLayoutConstraint.activate([
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Set passwordField constraints
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20), // Adjust the constant value as needed
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Set loginButton constraints
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo:  passwordField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
          ])
    }
    
    
    @objc func navigateToSigningScreen() {
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let tabBarController =  TabBarViewController()
            tabBarController.modalPresentationStyle = .fullScreen
            present( tabBarController, animated: true)
        }
    }
    

    //NavigationBar ConfigurATION
    private  func navBar() {
    let signUpButton = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .plain, target: self, action: #selector(navigateToSigningScreen))

         navigationItem.rightBarButtonItem = signUpButton
    }
    
    
    @objc func signInButtonTapped() {
        
        guard  !emailField.text!.isEmpty && !passwordField.text!.isEmpty && passwordField.text!.count >= 6  else {
            alertUserLoginError()
            return
        }
        AuthManager.shared.signin(email: emailField.text ?? "error", password: passwordField.text ?? "error") { check in
            if !check {
                self.alertUserLoginError()
            }else {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                HapticManager.shared.vibrateForSelection()
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.navigationItem.largeTitleDisplayMode = .always
                self.present(vc, animated: false)
            }
        }
        
    }
    
    private func labelLogin() {
        // Create a UITapGestureRecognizer and add it to the entryLabel
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginLabelTapped))
        entryLabel.isUserInteractionEnabled = true
        entryLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func loginLabelTapped() {
        let vc =  TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .always
         present(vc, animated: false)
   }
    
    private  func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to login in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dimiss", style: .cancel))
        present(alert, animated: true)
    }
    
}
