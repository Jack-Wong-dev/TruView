//
//  EditProfileVC.swift
//  TestingCTPano

    import UIKit
    import Photos
    import Firebase
    import FirebaseFirestore



    class EditProfileVC: UIViewController {
      
//MARK: Variables
      let db = Firestore.firestore()

      var user: AppUser!
      
      var image = UIImage() {
        didSet {
          editProfileViews.userImage.image = image
        }
      }
      
      var name = String()
      var email = String()
      var phone = String()
      var agency = String()
      var license = String()
      
      
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
        guard let userName = editProfileViews.nameTextField.text else {
          showAlert(title: "Error", message: "Please enter your name")
          return
        }
        guard let userEmail = editProfileViews.emailTextField.text else {
          showAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        guard let userPhone = editProfileViews.phoneTextField.text else {
          return
        }
        guard let userAgency = editProfileViews.agencyTextField.text else {
          return
        }
        guard let userLicense = editProfileViews.realtorLicenseTextField.text else {
          return
        }
        FirebaseAuthService.manager.updateUserFields(userName: userName) { (result) in
            switch result {
            case .success():
                FBService.manager.updateCurrentUser(name: userName, email: userEmail, phone: userPhone, agency: userAgency, license: userLicense, bio: " ", location: " ", libraryPermission: true) { [weak self] (nextResult) in
                    switch nextResult {
                    case .success():
                      let profile = TabBarController()
                        profile.selectedIndex = 2
                        profile.modalPresentationStyle = .overFullScreen
                        self!.present(profile, animated: true, completion: nil)
                    case .failure(let error):
                        print(error)
              }
            }
            case .failure(let error):
            print(error)
          }
        }
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
                name = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.emailTextField {
                email = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.phoneTextField {
                phone = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.agencyTextField {
                agency = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.realtorLicenseTextField {
                license = textField.text ?? " "
                textField.resignFirstResponder()
          }
          return true
        }
      
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
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
