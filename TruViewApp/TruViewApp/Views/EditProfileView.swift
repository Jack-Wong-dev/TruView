//
//  EditProfileView.swift
//  TestingCTPano
//
//  Created by Ian Cervone on 2/21/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
  
  var user = User()

    lazy var cancelButton: UIButton = {
      let button = UIButton()
      Utilities.styleBarButton(button: button, title: "Cancel")
      button.setTitleColor(.gray, for: .normal)
      return button
    }()
    
    lazy var saveButton: UIButton = {
      let button = UIButton()
      Utilities.styleBarButton(button: button, title: "Save")
      return button
    }()
    
    lazy var userImage: UIImageView = {
      let image = UIImageView()
      image.image = /*user.profilePic ?? */ UIImage(named: "profilePicPlaceHolder")
      return image
    }()
    
    lazy var selectImageButton: UIButton = {
      let button = UIButton()
      Utilities.styleBarButton(button: button, title: "select profile image")
      return button
    }()
    
    lazy var nameLabel: UILabel = {
      let label = UILabel()
      label.text = "Name"
      return label
    }()
    
    lazy var nameTextField: UITextField = {
      let tf = UITextField()
      tf.placeholder = user.name ?? "enter your name"
      return tf
    }()
    
    lazy var emailLabel: UILabel = {
      let label = UILabel()
      label.text = "Email"
      return label
    }()
        
    lazy var emailTextField: UITextField = {
      let tf = UITextField()
      tf.placeholder = user.email ?? "enter email"
      return tf
    }()
    
    lazy var phoneLabel: UILabel = {
      let label = UILabel()
      label.text = "Phone Number"
      return label
    }()
        
    lazy var phoneTextField: UITextField = {
      let tf = UITextField()
      tf.placeholder = user.phone ?? "enter phone number"
      return tf
    }()
    
    lazy var agencyLabel: UILabel = {
      let label = UILabel()
      label.text = "Company Name"
      return label
    }()
    
    lazy var agencyTextField: UITextField = {
      let tf = UITextField()
      tf.placeholder = user.agency ?? "enter company name"
      return tf
    }()
    
    lazy var realtorLicenseLabel: UILabel = {
      let label = UILabel()
      label.text = "Realtor License"
      return label
    }()
        
    lazy var realtorLicenseTextField: UITextField = {
      let tf = UITextField()
      tf.placeholder = user.license ?? "enter realator license number"
      return tf
    }()
    
    lazy var bioLabel: UILabel = {
      let label = UILabel()
      label.text = "Bio"
      return label
    }()
    
    lazy var bioTextView: UITextView = {
      let tv = UITextView()
      tv.text = user.bio ?? "enter bio"
      //MARK: need to set and change background color for BioTV when editing starts (propably should be done in delegate extension in VC)
      if tv.text == "enter bio" {
        tv.textColor = #colorLiteral(red: 0.7354657054, green: 0.4323248863, blue: 0.2110898495, alpha: 1)
      } else {
        tv.textColor = .black
      }
      tv.font = .systemFont(ofSize: 17)
      tv.backgroundColor = .clear
      tv.isUserInteractionEnabled = true
      return tv
    }()
  
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    setUpEditProfileViews()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }


//MARK: Set up Views
  
  private func setUpEditProfileViews() {
    cancelButtonSetUp()
    saveButtonSetUp()
    userImageSetUp()
    selectImageButtonSetUp()
    bioTextViewSetUp()
    bioLabelSetUp()
    editStackViewSetup()
  }
  
  private func cancelButtonSetUp() {
    addSubview(cancelButton)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      cancelButton.heightAnchor.constraint(equalToConstant: 25),
      cancelButton.widthAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  private func saveButtonSetUp() {
    addSubview(saveButton)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      saveButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
      saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
    ])
  }
  
  private func userImageSetUp() {
    addSubview(userImage)
    userImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      userImage.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 15),
      userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      userImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
      userImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
    ])
  }
  
  private func selectImageButtonSetUp() {
    addSubview(selectImageButton)
    selectImageButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      selectImageButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
      selectImageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      selectImageButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      selectImageButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)
    ])
  }
  
  private func editStackViewSetup() {
    let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, emailLabel, emailTextField, phoneLabel, phoneTextField, agencyLabel, agencyTextField, realtorLicenseLabel, realtorLicenseTextField])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    self.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 50),
      stackView.leadingAnchor.constraint(equalTo: bioTextView.leadingAnchor, constant: 5),
      stackView.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bioLabel.topAnchor, constant: stackView.frame.height / 10)
    ])
  }
  
private func bioLabelSetUp() {
  addSubview(bioLabel)
  bioLabel.translatesAutoresizingMaskIntoConstraints = false
  NSLayoutConstraint.activate([
      bioLabel.bottomAnchor.constraint(equalTo: bioTextView.topAnchor, constant: 5),
      bioLabel.leadingAnchor.constraint(equalTo: bioTextView.leadingAnchor, constant: 5),
      bioLabel.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor),
      bioLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
   
  private func bioTextViewSetUp() {
    addSubview(bioTextView)
    bioTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bioTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      bioTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      bioTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      bioTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
    ])
  }
  
}

