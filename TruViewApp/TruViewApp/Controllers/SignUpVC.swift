//
//  SignUpVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
  
  var emailEntered: String? = nil {
    didSet {
      
    }
  }
  
  var passwordEntered: String? = nil {
    didSet {
      
    }
  }
  
  
  // MARK: UI Objects

        lazy var signUpViews: SignUpView = {
          let su = SignUpView()
          su.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
          su.loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
          return su
        }()
              
        
  //MARK: Lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(signUpViews)
      setDelgates()
    }
  
    func setDelgates() {
        signUpViews.emailTextField.delegate = self
        signUpViews.passwordTextField.delegate = self
    }
    

  
  //MARK: Obj-C methods

    @objc func signUpButtonPressed() {
        guard let email = emailEntered, let password = passwordEntered else {
          showAlert(title: "Error", message: "Please enter an email and password.")
            return
        }

        guard Utilities.isEmailValid(email) else {
          showAlert(title: "Error", message: "Please enter a valid email.")
            return
        }

      guard Utilities.isPasswordValid(password) else {
        showAlert(title: "Error", message: "Password must have at least 8 characters.")
            return
        }

  //      FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
  //          self?.handleCreateAccountResponse(with: result)
  //      }
      
      let nextVC = EditProfileVC()
      print("login button pressed")
      nextVC.modalPresentationStyle = .overFullScreen
      present(nextVC, animated: true, completion: nil)
    }

    @objc func logInButtonPressed() {
           let loginVC = LogInVC()
           print("button pressed")
           loginVC.modalPresentationStyle = .formSheet
           present(loginVC, animated: true, completion: nil)
       }
    
  
  

}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == signUpViews.emailTextField {
            emailEntered = textField.text
            textField.resignFirstResponder()
      } else if textField == signUpViews.passwordTextField {
            passwordEntered = textField.text
            textField.resignFirstResponder()
      }
      return true
    }
}
