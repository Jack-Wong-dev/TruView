//
//  EditProfileVC.swift
//  TestingCTPano

    import UIKit
    import Photos
    import Firebase


    class EditProfileVC: UIViewController {
      
//MARK: Variables
      let db = Firestore.firestore()

      var user = AppUser() {
        didSet{
          
        }
      }
      
      var image = UIImage() {
        didSet {
          editProfileViews.userImage.image = image
        }
      }
      
// MARK: UI Objects

      lazy var editProfileViews: EditProfileView = {
        let epv = EditProfileView()
        epv.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        epv.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        epv.selectImageButton.addTarget(self, action: #selector(addFromLibrary), for: .touchUpInside)
        return epv
      }()
            
      
//MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editProfileViews)
        view.backgroundColor = .white
        setDelgates()
      }
      
      override func viewDidLayoutSubviews() {
        Utilities.roundImageView(image: editProfileViews.userImage)
        Utilities.styleTextField(editProfileViews.nameTextField)
        Utilities.styleTextField(editProfileViews.emailTextField)
        Utilities.styleTextField(editProfileViews.phoneTextField)
        Utilities.styleTextField(editProfileViews.agencyTextField)
        Utilities.styleTextField(editProfileViews.realtorLicenseTextField)
      }
      
      func setDelgates() {
        editProfileViews.nameTextField.delegate = self
        editProfileViews.emailTextField.delegate = self
        editProfileViews.phoneTextField.delegate = self
        editProfileViews.agencyTextField.delegate = self
        editProfileViews.realtorLicenseTextField.delegate = self
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
        guard user.name != "enter your name" else {
          showAlert(title: "Error", message: "Please enter your name")
          return
        }
        guard user.name != "" else {
          showAlert(title: "Error", message: "Please enter your name")
          return
        }
        db.collection("users").document("realtor").setData([
          "name": user.name,
            "email": user.email,
            "phone": user.phone,
            "agency": user.agency,
            "license": user.license,
            "bio": user.bio,
            "profilePic": user.profilePic
          
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        let profile = ProfileVC()
        profile.modalPresentationStyle = .overFullScreen
        present(profile, animated: true, completion: nil)
      }
      
      
      @objc func addFromLibrary() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = .photoLibrary
        present(imagePickerVC, animated: true, completion: nil)
      }
          
        
    }



//MARK: Extensions
    extension EditProfileVC: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == editProfileViews.nameTextField {
                user.name = textField.text
                textField.resignFirstResponder()
          } else if textField == editProfileViews.emailTextField {
                user.email = textField.text
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
    guard let newImage = info[.originalImage] as? UIImage else {
      return
    }
    self.image = newImage
    dismiss(animated: true, completion: nil)
  }
}

extension EditProfileVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.textColor = .black
  }
}
