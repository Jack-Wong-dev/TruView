//
//  LogInVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
//import FirebaseAuth

class LogInVC: UIViewController {
  
  var emailEntered: String? = nil {
    didSet {
      
    }
  }
  
  var passwordEntered: String? = nil {
    didSet {
      
    }
  }
  
  
  // MARK: UI Objects

        lazy var loginViews: LoginView = {
          let login = LoginView()
          login.loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
          login.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
          return login
        }()
              
        
  //MARK: Lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(loginViews)
      viewDidLayoutSubviews()
      setDelgates()
    }
  
    override func viewDidLayoutSubviews() {
        Utilities.styleTextField(loginViews.emailTextField)
        Utilities.styleTextField(loginViews.passwordTextField)
    }
  
    func setDelgates() {
        loginViews.emailTextField.delegate = self
        loginViews.passwordTextField.delegate = self
    }
    

  
  //MARK: Obj-C methods

    @objc func signUpButtonPressed() {
      
      let nextVC = SignUpVC()
      print("login button pressed")
      nextVC.modalPresentationStyle = .overFullScreen
      present(nextVC, animated: true, completion: nil)
    }

    @objc func logInButtonPressed() {
          guard let email = emailEntered, let password = passwordEntered else {
              showAlert(with: "Error", and: "Please fill out all fields.")
              return
          }
          guard Utilities.isEmailValid(email) else {
              showAlert(with: "Error", and: "Please enter a valid email")
              return
          }
               
//          guard Utilities.isPasswordValid(password) else {
          //        showAlert(title: "Error", message: "Password must have at least 8 characters.")
          //            return
//          }
          FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
              self.handleLoginResponse(with: result)
          }
      }
           
    
//MARK: Private Functions
  
  private func showAlert(with title: String, and message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
  }
  
  
  private func handleLoginResponse(with result: Result<(), Error>) {
      switch result {
      case .failure(let error):
          showAlert(with: "Error", and: "Could not log in. Error: \(error)")
      case .success:
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
              else {
                  return
          }
          UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            window.rootViewController = EditProfileVC()
          }, completion: nil)
      }
  }


}


//MARK: Delegates

extension LogInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == loginViews.emailTextField {
            emailEntered = textField.text
            textField.resignFirstResponder()
      } else if textField == loginViews.passwordTextField {
            passwordEntered = textField.text
            textField.resignFirstResponder()
      }
      return true
    }
}
