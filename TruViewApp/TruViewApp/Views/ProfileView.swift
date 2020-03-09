//
//  ProfileView.swift
//  TruViewApp
//
//  Created by Ian Cervone on 2/21/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ProfileView: UIView {
  
  let spacing = CGFloat(20) /* used to set leading/trailing spaces for constraints */

    lazy var editProfileButton: UIButton = {
      let button = UIButton()
      Utilities.styleBarButton(button: button, title: "edit")
      button.titleLabel!.font = UIFont.systemFont(ofSize: 17)
      button.setTitleColor(.systemBlue, for: .normal)
      return button
    }()
  
   lazy var userImage: UIImageView = {
      let image = UIImageView()
      image.image = /*user.profilePic ?? */ UIImage(named: "profilePicPlaceHolder")
      return image
    }()
  
  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Rene Rodriguez"
    label.font = label.font.withSize(25)
    return label
  }()
  
  lazy var agencyLabel: UILabel = {
    let label = UILabel()
    label.text = "Cabot Residential"
    return label
  }()
  
  lazy var bioTextView: UITextView = {
    let tv = UITextView()
    tv.text = "BIO: Rene Rodriguez is one of New York's most trusted and top-selling brokers, counting among his clients numerous distinguished business and community leaders. A member of the Cabot Residential team since 1996, Rene works with individuals, investors, and developers interested in the city’s most coveted properties—with a particular focus on the Back Bay, Beacon Hill, and South End neighborhoods"
    tv.font = tv.font!.withSize(17)
    tv.backgroundColor = .clear
    tv.isUserInteractionEnabled = false
    return tv
  }()
  
  lazy var memberSinceLabel: UILabel = {
     let label = UILabel()
    label.text = "TruView Member Since:  Jan 2020"
     return label
   }()
  
  lazy var realtorLicenseLabel: UILabel = {
     let label = UILabel()
    label.text = "Realtor License:  NYS-334258ACH"
     return label
   }()
  
  lazy var viewAllListingsButton: UIButton = {
    let button = UIButton()
    Utilities.styleBarButton(button: button, title: "view all listings")
    button.setTitleColor(.systemBlue, for: .normal)
    button.backgroundColor = .clear
    return button
  }()
  
  lazy var listingsCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
//    layout.minimumLineSpacing = 5
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.register(ListingCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue)
    cv.register(AddContentCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.addContentCell.rawValue)
    cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
    return cv
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
      editProfileButtonsetUp()
      userImagesetUp()
      nameLabelsetUp()
      viewAllListingsButtonsetUp()
      listingsCollectionViewsetUp()
      memberSinceLabelsetUp()
      realtorLicenseLabelsetUp()
      agencyLabelsetUp()
      bioTextViewsetUp()
    }
  
  
  private func editProfileButtonsetUp() {
    addSubview(editProfileButton)
       editProfileButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         editProfileButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         editProfileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
         editProfileButton.heightAnchor.constraint(equalToConstant: 25),
         editProfileButton.widthAnchor.constraint(equalToConstant: 60)
       ])
     }
  
  private func userImagesetUp() {
    addSubview(userImage)
      userImage.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        userImage.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 15),
        userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
        userImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
        userImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
      ])
    }
  
  private func nameLabelsetUp() {
    addSubview(nameLabel)
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        nameLabel.bottomAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 0),
        nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 0),
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        nameLabel.heightAnchor.constraint(equalToConstant: 40)
      ])
    }
  
  private func bioTextViewsetUp() {
   addSubview(bioTextView)
      bioTextView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        bioTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
        bioTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
        bioTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(spacing)),
        bioTextView.bottomAnchor.constraint(equalTo: agencyLabel.topAnchor)
      ])
    }
  
  private func agencyLabelsetUp() {
  addSubview(agencyLabel)
     agencyLabel.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([
       agencyLabel.bottomAnchor.constraint(equalTo: realtorLicenseLabel.topAnchor, constant: -5),
       agencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
       agencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing),
       agencyLabel.heightAnchor.constraint(equalToConstant: 25)
     ])
   }
  
  private func realtorLicenseLabelsetUp() {
    addSubview(realtorLicenseLabel)
       realtorLicenseLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         realtorLicenseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
         realtorLicenseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing),
         realtorLicenseLabel.bottomAnchor.constraint(equalTo: memberSinceLabel.topAnchor, constant: -5),
        realtorLicenseLabel.heightAnchor.constraint(equalToConstant: 25)
       ])
     }
  
  private func memberSinceLabelsetUp() {
     addSubview(memberSinceLabel)
        memberSinceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          memberSinceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
          memberSinceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing),
          memberSinceLabel.heightAnchor.constraint(equalToConstant: 25),
          memberSinceLabel.bottomAnchor.constraint(equalTo: listingsCollectionView.topAnchor, constant: -25)
        ])
      }
  
  private func listingsCollectionViewsetUp() {
    addSubview(listingsCollectionView)
         listingsCollectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
           listingsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
           listingsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
           listingsCollectionView.heightAnchor.constraint(equalToConstant: 150),
           listingsCollectionView.bottomAnchor.constraint(equalTo: viewAllListingsButton.topAnchor, constant: -5)
         ])
       }
  
  private func viewAllListingsButtonsetUp() {
  addSubview(viewAllListingsButton)
            viewAllListingsButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
              viewAllListingsButton.leadingAnchor.constraint(equalTo: leadingAnchor),
              viewAllListingsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
              viewAllListingsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
             viewAllListingsButton.heightAnchor.constraint(equalToConstant: 25)
            ])
          }
  
}
