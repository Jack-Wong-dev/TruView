

import Foundation
import UIKit

class Utilities {
  
  
  static func styleBarButton(button: UIButton, title: String) {
      button.setTitle(title, for: .normal)
      button.titleLabel!.font = UIFont(name: "San Francisco", size: 20)
      button.setTitleColor(.systemBlue, for: .normal)
  }
  
  
  static func roundImageView(image:UIImageView) {
    // call in viewDidLayoutSubviews
      image.layer.masksToBounds = false
      image.layer.cornerRadius = image.frame.height/2
      image.clipsToBounds = true
  }
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 1)
        
        //        bottomLine.frame = CGRect(x: 0, y: 50 - 2, width: 300, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 23/255, green: 123/255, blue: 174/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
        
        textfield.returnKeyType = .next
        
    }
    
    static func styleTextView(_ textView: UITextView) {
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textView.frame.height - 2, width: textView.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 23/255, green: 123/255, blue: 174/255, alpha: 1).cgColor
        
        textView.layer.addSublayer(bottomLine)
        
        textView.returnKeyType = .next
        
    }
    
    static func styleSecureTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        //          bottomLine.frame = CGRect(x: 0, y: 50 - 2, width: 300, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 23/255, green: 123/255, blue: 174/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
        textfield.isSecureTextEntry = true
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
        textfield.returnKeyType = .go
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        
        button.backgroundColor = UIColor.init(red: 23/255, green: 123/255, blue: 174/255, alpha: 1)
        
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        //        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25.0
        //        button.tintColor = UIColor.black
        button.tintColor = UIColor.white
    }
    
    static func isEmailValid(_ email : String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func showAlert(on: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: completion)
    }
    
}
