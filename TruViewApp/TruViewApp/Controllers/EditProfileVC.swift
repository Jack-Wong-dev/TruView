//
//  EditProfileVC.swift
//  TestingCTPano

    import UIKit
    import Photos

    class EditProfileVC: UIViewController {
      
//MARK: Variables
      var user = User()
      
      
      lazy var editProfileViews: EditProfileView = {
        let epv = EditProfileView()
        epv.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        epv.selectImageButton.addTarget(self, action: #selector(addFromLibrary), for: .touchUpInside)
        return epv
      }()
            
      
//MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editProfileViews)
        view.setGradientBackground(colorTop: #colorLiteral(red: 0.9686274529, green: 0.8481872751, blue: 0.1920395687, alpha: 1), colorBottom: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
      }
      
      override func viewDidLayoutSubviews() {
        Utilities.roundImageView(image: editProfileViews.userImage)
        Utilities.styleTextField(editProfileViews.nameTextField)
        Utilities.styleTextField(editProfileViews.emailTextField)
        Utilities.styleTextField(editProfileViews.phoneTextField)
        Utilities.styleTextField(editProfileViews.agencyTextField)
        Utilities.styleTextField(editProfileViews.realtorLicenseTextField)
      }
      
     
      
      
//MARK: Objc Functions
      @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
      }
      
      
      @objc func  saveButtonPressed() {
        guard Utilities.isEmailValid(user.email ?? "") else {
          showAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        guard user.name != "" else {
          showAlert(title: "Error", message: "Please enter your name")
          return
        }
        let profile = ProfileVC()
        profile.modalPresentationStyle = .overFullScreen
        present(profile, animated: true, completion: nil)
      }
      
      
      @objc func addFromLibrary() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = .photoLibrary
        
        if user.libraryPermission {
          imagePickerVC.delegate = self
          present(imagePickerVC, animated: true, completion: nil)
        } else {
          let alertVC = UIAlertController(title: "Access Required", message: "Library access is required to add photos", preferredStyle: .alert)
          
          alertVC.addAction(UIAlertAction(title: "Deny", style: .destructive, handler: nil))
          self.present(alertVC, animated: true, completion: nil)
          
          alertVC.addAction(UIAlertAction(title: "Allow", style: .default, handler: {(action) in
            self.user.libraryPermission = true
            self.present(imagePickerVC, animated: true, completion: nil)
          }))
        }
      }
      
      
      
//MARK: Check Library Permission

      //MARK: Should the function below be refactored and placed in a ModelView?
      func checkLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
          print(status)
        case .notDetermined:
          PHPhotoLibrary.requestAuthorization({status in
            switch status {
            case . authorized:
              self.user.libraryPermission = true
              print(status)
            case .denied:
              self.user.libraryPermission = false
              print("denied")
            case .notDetermined:
              print("not determined")
            case .restricted:
              print("restricted")
            }
          })
        case .denied:
          let alertVC = UIAlertController(title: "Denied ", message: "Camera access is required for this app", preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        case .restricted:
          print("restricted")
        }
      }
      
        
    }


//MARK: Extensions
    extension EditProfileVC: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == editProfileViews.nameTextField {
                user.name = textField.text ?? ""
                textField.resignFirstResponder()
          } else if textField == editProfileViews.emailTextField {
                user.email = textField.text ?? ""
                textField.resignFirstResponder()
          } else if textField == editProfileViews.phoneTextField {
                user.phone = textField.text
                textField.resignFirstResponder()
          } else if textField == editProfileViews.agencyTextField {
                user.agency = textField.text
                textField.resignFirstResponder()
          } else if textField == editProfileViews.realtorLicenseTextField {
                user.license = textField.text
                textField.resignFirstResponder()
          }
          return true
        }
    }


extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {
      return
    }
//    self.user.profilePic = image
    dismiss(animated: true, completion: nil)
  }
}

extension EditProfileVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.textColor = .black
  }
}
