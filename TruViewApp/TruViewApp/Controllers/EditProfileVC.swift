//
//  EditProfileVC.swift
//  TestingCTPano

    import UIKit
    import Photos

    class EditProfileVC: UIViewController {
      
//MARK: Variables
      var profileName: String = ""
      var profileEmail: String = ""
      var profilePhone: String?
      var profileAgency: String?
      var profileLicense: String?
      var profileBio: String?
      var libraryPermission: Bool = false
      var profileImage = UIImage() {
        didSet {
           userImage.image = profileImage
         }
       }
      
//MARK: Views
      lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel!.font = UIFont(name: "San Francisco", size: 20)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        return button
      }()
      
      lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel!.font = UIFont(name: "San Francisco", size: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
      }()
      
      lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        image.layer.cornerRadius = 75
        image.layer.masksToBounds = true
        return image
      }()
      
      lazy var selectImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("select profile image", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addFromLibrary), for: .touchUpInside)
        return button
      }()
      
      lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
      }()
      
      lazy var nameTextField: UITextField = {
        let tf = UITextField()
        Utilities.styleTextField(tf)
        tf.delegate = self
        return tf
      }()
      
      lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        return label
      }()
          
      lazy var emailTextField: UITextField = {
        let tf = UITextField()
        Utilities.styleTextField(tf)
        tf.delegate = self
        return tf
      }()
      
      lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        return label
      }()
          
      lazy var phoneTextField: UITextField = {
        let tf = UITextField()
        Utilities.styleTextField(tf)
        tf.delegate = self
        return tf
      }()
      
      lazy var agencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        return label
      }()
      
      lazy var agencyTextField: UITextField = {
        let tf = UITextField()
        Utilities.styleTextField(tf)
        tf.delegate = self
        return tf
      }()
      
      lazy var realtorLicenseLabel: UILabel = {
        let label = UILabel()
        label.text = "Realtor License"
        return label
      }()
          
      lazy var realtorLicenseTextField: UITextField = {
        let tf = UITextField()
        Utilities.styleTextField(tf)
        tf.delegate = self
        return tf
      }()
      
      lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        return label
      }()
      
      lazy var bioTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.backgroundColor = .clear
        tv.isUserInteractionEnabled = false
        return tv
      }()
      
      
//MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        view.setGradientBackground(colorTop: #colorLiteral(red: 0.9686274529, green: 0.8481872751, blue: 0.1920395687, alpha: 1), colorBottom: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
      }
      
      
//MARK: Objc Functions
      @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
      }
      
      @objc func  saveButtonPressed() {
        guard Utilities.isEmailValid(profileEmail) else {
          showAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        guard profileName != "" else {
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
        
        if libraryPermission {
          imagePickerVC.delegate = self
          present(imagePickerVC, animated: true, completion: nil)
        } else {
          let alertVC = UIAlertController(title: "Access Required", message: "Library access is required to add photos", preferredStyle: .alert)
          
          alertVC.addAction(UIAlertAction(title: "Deny", style: .destructive, handler: nil))
          self.present(alertVC, animated: true, completion: nil)
          
          alertVC.addAction(UIAlertAction(title: "Allow", style: .default, handler: {(action) in
            self.libraryPermission = true
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
              self.libraryPermission = true
              print(status)
            case .denied:
              self.libraryPermission = false
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
      
        
//MARK: Set up Views
      private func setUpViews() {
        cancelButtonSetUp()
        saveButtonSetUp()
        userImageSetUp()
        selectImageButtonSetUp()
        nameLabelSetUp()
        nameTextFieldSetUp()
        emailLabelSetUp()
        emailTextFieldSetUp()
        phoneLabelSetUp()
        phoneTextFieldSetUp()
        agencyLabelSetUp()
        agencyTextFieldSetUp()
        realtorLicenseLabelSetUp()
        realtorLicenseTextFieldSetUp()
        bioLabelSetUp()
        bioTextViewSetUp()
      }
      
      private func cancelButtonSetUp() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
          cancelButton.heightAnchor.constraint(equalToConstant: 25),
          cancelButton.widthAnchor.constraint(equalToConstant: 60)
        ])
      }

      
      private func saveButtonSetUp() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
          saveButton.heightAnchor.constraint(equalToConstant: 25),
          saveButton.widthAnchor.constraint(equalToConstant: 40)
        ])
      }
      
      private func userImageSetUp() {
        view.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          userImage.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
          userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          userImage.widthAnchor.constraint(equalToConstant: 150),
          userImage.heightAnchor.constraint(equalToConstant: 150)
        ])
      }
      
      private func selectImageButtonSetUp() {
        view.addSubview(selectImageButton)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          selectImageButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
          selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
          selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          selectImageButton.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
      private func nameLabelSetUp() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          nameLabel.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 15),
          nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
      
      private func nameTextFieldSetUp() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
          nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          nameTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
      private func emailLabelSetUp() {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
          emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          emailLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
      
      private func emailTextFieldSetUp() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
          emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          emailTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
      private func phoneLabelSetUp() {
        view.addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          phoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
          phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          phoneLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
      
      private func phoneTextFieldSetUp() {
        view.addSubview(phoneTextField)
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor),
          phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          phoneTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
      private func agencyLabelSetUp() {
        view.addSubview(agencyLabel)
        agencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          agencyLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 15),
          agencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          agencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          agencyLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
        
      private func agencyTextFieldSetUp() {
        view.addSubview(agencyTextField)
        agencyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          agencyTextField.topAnchor.constraint(equalTo: agencyLabel.bottomAnchor),
          agencyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          agencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          agencyTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
          
      private func realtorLicenseLabelSetUp() {
        view.addSubview(realtorLicenseLabel)
        realtorLicenseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          realtorLicenseLabel.topAnchor.constraint(equalTo: agencyTextField.bottomAnchor, constant: 15),
          realtorLicenseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          realtorLicenseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          realtorLicenseLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
           
      private func realtorLicenseTextFieldSetUp() {
        view.addSubview(realtorLicenseTextField)
        realtorLicenseTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          realtorLicenseTextField.topAnchor.constraint(equalTo: realtorLicenseLabel.bottomAnchor),
          realtorLicenseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          realtorLicenseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          realtorLicenseTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
    private func bioLabelSetUp() {
      view.addSubview(bioLabel)
      bioLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          bioLabel.topAnchor.constraint(equalTo: realtorLicenseTextField.bottomAnchor, constant: 15),
          bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          bioLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
       
      private func bioTextViewSetUp() {
        view.addSubview(bioTextView)
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
          bioTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          bioTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          bioTextView.heightAnchor.constraint(equalToConstant: 25)
        ])
      }
      
    }


//MARK: Extensions
    extension EditProfileVC: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == nameTextField {
                profileName = textField.text ?? ""
                textField.resignFirstResponder()
              print(profileName)
              } else if textField == emailTextField {
                profileEmail = textField.text ?? ""
                textField.resignFirstResponder()
              } else if textField == phoneTextField {
                profilePhone = textField.text
                textField.resignFirstResponder()
              } else if textField == agencyTextField {
                profileAgency = textField.text
                textField.resignFirstResponder()
              } else if textField == realtorLicenseTextField {
                profileLicense = textField.text
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
    self.profileImage = image
    dismiss(animated: true, completion: nil)
  }
}
