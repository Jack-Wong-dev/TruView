//
//  SignUpView.swift
//  TruViewApp
//
//  Created by Jack Wong on 3/3/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class SignUpView: UIView {
  
      lazy var emailLabel: UILabel = {
          let label = UILabel()
          label.text = "Email"
          return label
        }()
      
      lazy var emailTextField: UITextField = {
          let tf = UITextField()
          tf.placeholder = "enter email"
          return tf
      }()
  
      lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        return label
      }()

      lazy var passwordTextField: UITextField = {
          let tf = UITextField()
          tf.placeholder = "enter password"
          return tf
      }()
  
      lazy var signUpButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("SIGN UP", for: .normal)
          button.isEnabled = true
        return button
      }()

      lazy var loginButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("LOGIN", for: .normal)
          button.isEnabled = true
          return button
      }()
  
// MARK: Initializers
    override init(frame: CGRect) {
      super.init(frame: UIScreen.main.bounds)
      setUpSignUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


//MARK: Setup Views
    
    private func setUpSignUpViews() {
      
      editStackViewSetup()
      signUpButtonSetup()
      loginButtonSetup()
    }
    
    private func editStackViewSetup() {
      let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField])
      stackView.axis = .vertical
      stackView.distribution = .fillEqually
      self.addSubview(stackView)

      stackView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        stackView.heightAnchor.constraint(equalToConstant: 200),
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        stackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20)
      ])
    }
    
    private func signUpButtonSetup() {
      addSubview(signUpButton)
      signUpButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        signUpButton.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: -20),
        signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        signUpButton.widthAnchor.constraint(equalToConstant: 30),
        signUpButton.heightAnchor.constraint(equalToConstant: 100)
      ])
    }
    
    private func loginButtonSetup() {
      addSubview(loginButton)
      loginButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
        loginButton.heightAnchor.constraint(equalToConstant: 30),
        loginButton.widthAnchor.constraint(equalToConstant: 100)
      ])
    }
    
    
  }
