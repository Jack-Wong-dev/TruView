
import UIKit

class ProfileVC: UIViewController {
    
//MARK: VIEWS
  lazy var createListingButton: UIButton = {
    let button = UIButton()
    button.setTitle("+", for: .normal)
    button.titleLabel!.font = UIFont(name: "Optima-Regular", size: 50)
    button.setTitleColor(.systemBlue, for: .normal)
    button.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    return button
  }()
  
  lazy var editProfileButton: UIButton = {
    let button = UIButton()
    button.setTitle("edit", for: .normal)
    button.titleLabel!.font = UIFont(name: "Optima-Regular", size: 40)
    button.setTitleColor(.systemBlue, for: .normal)
    button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
    return button
  }()
  
  lazy var userImage: UIImageView = {
    let image = UIImageView()
    image.backgroundColor = .green
    image.layer.cornerRadius = 75
    image.layer.masksToBounds = true
    return image
  }()
  
  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Jane Monopoly"
    return label
  }()
  
  lazy var agencyLabel: UILabel = {
    let label = UILabel()
    label.text = "Monopoly Realty"
    return label
  }()
  
  lazy var bioTextView: UITextView = {
    let tv = UITextView()
    tv.text = "Realtor Bio: "
    tv.backgroundColor = .clear
    tv.isUserInteractionEnabled = false
    return tv
  }()
  
  lazy var memberSinceLabel: UILabel = {
     let label = UILabel()
    label.text = "Member Since: Jan 2020"
     return label
   }()
  
  lazy var realtorLicenseLabel: UILabel = {
     let label = UILabel()
    label.text = "Realtor License: ABC123"
     return label
   }()
  
  lazy var viewAllListingsButton: UIButton = {
    let button = UIButton()
    button.setTitle("view all listings", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.addTarget(self, action: #selector(viewAllButtonPressed), for: .touchUpInside)
    return button
  }()
  
  lazy var listingsCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .clear
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 5
    cv.dataSource = self
    cv.delegate = self
    cv.register(ListingCVCell.self, forCellWithReuseIdentifier: "listingCell")
    return cv
  }()
  
  
//MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        view.setGradientBackground(colorTop: #colorLiteral(red: 0.9686274529, green: 0.8481872751, blue: 0.1920395687, alpha: 1), colorBottom: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    }
  
  
//MARK: OBJC FUNCTIONS
  @objc func createButtonPressed() {
    let createListing = CreateListingVC()
    createListing.modalPresentationStyle = .overFullScreen
    present(createListing, animated: true, completion: nil)
  }

  @objc func editButtonPressed() {
    let editProfile = EditProfileVC()
    editProfile.modalPresentationStyle = .overFullScreen
    present(editProfile, animated: true, completion: nil)
  }

  @objc func viewAllButtonPressed() {
    let listings = ListingsVC()
    listings.modalPresentationStyle = .overFullScreen
    present(listings, animated: true, completion: nil)
  }

    
//MARK: SET UP VIEWS
  private func setUpViews() {
    createListingButtonsetUp()
    editProfileButtonsetUp()
    userImagesetUp()
    agencyLabelsetUp()
    nameLabelsetUp()
    listingsCollectionViewsetUp()
    viewAllListingsButtonsetUp()
    realtorLicenseLabelsetUp()
    memberSinceLabelsetUp()
    bioTextViewsetUp()
  }
  
  private func createListingButtonsetUp() {
    view.addSubview(createListingButton)
    createListingButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      createListingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      createListingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      createListingButton.heightAnchor.constraint(equalToConstant: 30),
      createListingButton.widthAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  private func editProfileButtonsetUp() {
    view.addSubview(editProfileButton)
       editProfileButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         editProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
         editProfileButton.heightAnchor.constraint(equalToConstant: 25),
         editProfileButton.widthAnchor.constraint(equalToConstant: 40)
       ])
     }
  
  private func userImagesetUp() {
    view.addSubview(userImage)
      userImage.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        userImage.topAnchor.constraint(equalTo: createListingButton.bottomAnchor, constant: 15),
        userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
        userImage.heightAnchor.constraint(equalToConstant: 150),
        userImage.widthAnchor.constraint(equalToConstant: 150)
      ])
    }
  
  private func nameLabelsetUp() {
    view.addSubview(nameLabel)
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        nameLabel.bottomAnchor.constraint(equalTo: agencyLabel.topAnchor, constant: -10),
        nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        nameLabel.heightAnchor.constraint(equalToConstant: 25)
      ])
    }
  
  private func agencyLabelsetUp() {
   view.addSubview(agencyLabel)
      agencyLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        agencyLabel.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
        agencyLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),
        agencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        agencyLabel.heightAnchor.constraint(equalToConstant: 25)
      ])
    }
  
  private func bioTextViewsetUp() {
   view.addSubview(bioTextView)
      bioTextView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        bioTextView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
        bioTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
        bioTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        bioTextView.bottomAnchor.constraint(equalTo: memberSinceLabel.topAnchor)
      ])
    }
  
  private func memberSinceLabelsetUp() {
    view.addSubview(memberSinceLabel)
       memberSinceLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         memberSinceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
         memberSinceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         memberSinceLabel.heightAnchor.constraint(equalToConstant: 25),
         memberSinceLabel.bottomAnchor.constraint(equalTo: realtorLicenseLabel.topAnchor)
       ])
     }
  
  private func realtorLicenseLabelsetUp() {
    view.addSubview(realtorLicenseLabel)
       realtorLicenseLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         realtorLicenseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
         realtorLicenseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         realtorLicenseLabel.bottomAnchor.constraint(equalTo: viewAllListingsButton.topAnchor, constant: -20),
        realtorLicenseLabel.heightAnchor.constraint(equalToConstant: 25)
       ])
     }
  
  private func viewAllListingsButtonsetUp() {
   view.addSubview(viewAllListingsButton)
             viewAllListingsButton.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
               viewAllListingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
               viewAllListingsButton.widthAnchor.constraint(equalToConstant: 150),
               viewAllListingsButton.bottomAnchor.constraint(equalTo: listingsCollectionView.topAnchor),
              viewAllListingsButton.heightAnchor.constraint(equalToConstant: 25)
             ])
           }
  
  private func listingsCollectionViewsetUp() {
   view.addSubview(listingsCollectionView)
          listingsCollectionView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            listingsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listingsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listingsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            listingsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
        }
  
  
}


extension ProfileVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as! ListingCVCell
        return cell
  }
}


extension ProfileVC: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
             collectionView.deselectItem(at: indexPath, animated: true)
           let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
             return false
        }
    return false
  }
}


extension ProfileVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let cellSize = CGSize(width: 200, height: 200)
        return cellSize
    }
}
