//
//  EditProfileVC.swift
//  TestingCTPano

    import UIKit
    import Photos
   

    class EditProfileVC: UIViewController {
      
//MARK: Variables
      let currentUser = FirebaseAuthService.manager.currentUser
      

      var user: AppUser!
  
      var userName = String() {
        didSet {
          editProfileViews.nameTextField.text = userName
        }
      }
      
      var userEmail = String() {
             didSet {
               editProfileViews.emailTextField.text = userEmail
             }
           }
      
      var userPhone = String() {
             didSet {
               editProfileViews.phoneTextField.placeholder = userPhone
             }
           }
      
      var userAgency = String() {
             didSet {
               editProfileViews.agencyTextField.placeholder = userAgency
             }
           }
      
      var userLicense = String() {
             didSet {
               editProfileViews.realtorLicenseTextField.placeholder = userLicense
             }
           }
      
      var profilePic = UIImage() {
             didSet {
               editProfileViews.userImage.image = profilePic
             }
           }
      var imageURL: URL? = nil
      
      
// MARK: UI Objects

      lazy var editProfileViews: EditProfileView = {
        let epv = EditProfileView()
        epv.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        epv.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        epv.selectImageButton.addTarget(self, action: #selector(addProfieImage), for: .touchUpInside)
        return epv
      }()
            
      
//MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrentUser()
        view.addSubview(editProfileViews)
        view.backgroundColor = .white
        setDelgates()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          loadUser()
      }
      
      override func viewDidLayoutSubviews() {
        Utilities.roundImageView(image: editProfileViews.userImage)
        Utilities.styleTextField(editProfileViews.nameTextField)
        Utilities.styleTextField(editProfileViews.emailTextField)
        Utilities.styleTextField(editProfileViews.phoneTextField)
        Utilities.styleTextField(editProfileViews.agencyTextField)
        Utilities.styleTextField(editProfileViews.realtorLicenseTextField)
      }
     
//MARK: Private Functions
      private func setDelgates() {
        editProfileViews.nameTextField.delegate = self
        editProfileViews.emailTextField.delegate = self
        editProfileViews.phoneTextField.delegate = self
        editProfileViews.agencyTextField.delegate = self
        editProfileViews.realtorLicenseTextField.delegate = self
      }
      
      private func checkCurrentUser() {
        if currentUser == nil {
          let logIn = LogInVC()
          logIn.modalPresentationStyle = .overFullScreen
          self.present(logIn, animated: true, completion: nil)
        }
      }
      
      private func loadUser() {
        FBService.manager.getUserInfo(userEmail: currentUser?.email ?? "") { [weak self] (result) in
             switch result {
             case .success(let currentUser):
              if let name = currentUser.name {
                self?.userName = name
              }
              if let email = currentUser.email {
              self?.userEmail = email
              }
              if let phone = currentUser.phone {
              self?.userPhone = phone
              }
              if let agency = currentUser.agency {
              self?.userAgency = agency
              }
              if let license = currentUser.license {
              self?.userLicense = license
              } 
             case .failure(let error):
               print("couldn't load \(self?.user.name ?? "") profile: \(error)")
          }
        }
      }
      
      
      
//MARK: Objc Functions
      @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
      }
      
      
      @objc func saveButtonPressed() {
        guard let userName = editProfileViews.nameTextField.text else {
          showAlert(title: "Error", message: "Please enter your name")
          print("save button pressed1")
          return
        }
        guard let userEmail = editProfileViews.emailTextField.text else {
          showAlert(title: "Error", message: "Please enter a valid email")
          print("save button pressed2")
            return
        }
        guard let userPhone = editProfileViews.phoneTextField.text else {
          print("save button pressed3")
          return
        }
        guard let userAgency = editProfileViews.agencyTextField.text else {
          return
        }
        guard let userLicense = editProfileViews.realtorLicenseTextField.text else {
          return
        }
        guard let userProfilePic = imageURL else {
          return
        }
        FirebaseAuthService.manager.updateUserFields(userName: userName) { (result) in
            switch result {
            case .success():
              FBService.manager.updateCurrentUser(name: userName, email: userEmail, phone: userPhone, agency: userAgency, license: userLicense, profilePic: userProfilePic, bio: " ", libraryPermission: true) { [weak self] (nextResult) in
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
      
      @objc func addProfieImage() {
        DispatchQueue.main.async{
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = .photoLibrary
          self.present(imagePickerVC, animated: true, completion: nil)
          }
        }
      
      
    }



//MARK: Extensions
    extension EditProfileVC: UITextFieldDelegate {
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == editProfileViews.nameTextField {
                userName = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.emailTextField {
                userEmail = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.phoneTextField {
                userPhone = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.agencyTextField {
                userAgency = textField.text ?? " "
                textField.resignFirstResponder()
          } else if textField == editProfileViews.realtorLicenseTextField {
                userLicense = textField.text ?? " "
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
    self.profilePic = newImage
    dismiss(animated: true, completion: nil)
  }
}

extension EditProfileVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.textColor = .black
  }
}
