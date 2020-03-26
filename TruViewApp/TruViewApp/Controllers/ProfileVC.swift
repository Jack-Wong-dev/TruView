
import UIKit
import Firebase

class ProfileVC: UIViewController {
    
//MARK: Variables

  var user: AppUser?
  
  
  
// MARK: - UI Objects
  
  lazy var profileViews: ProfileView = {
    let pv = ProfileView()
    pv.editProfileButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
    pv.viewAllListingsButton.addTarget(self, action: #selector(viewAllButtonPressed), for: .touchUpInside)
    pv.listingsCollectionView.dataSource = self
    pv.listingsCollectionView.delegate = self
    
    if let currentUser = Auth.auth().currentUser {
      print(currentUser)
      pv.editProfileButton.isHidden = false
    } else {
      pv.editProfileButton.isHidden = true

    }
    
    return pv
  }()
  
  
  
  
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(profileViews)
      view.backgroundColor = .systemBackground
    }
  
  override func viewDidLayoutSubviews() {
  Utilities.roundImageView(image: profileViews.userImage)
  }
  
  
//MARK: Objc FUNCTIONS
  @objc func editButtonPressed() {
    let editProfile = EditProfileVC()
    editProfile.modalPresentationStyle = .fullScreen
    present(editProfile, animated: true, completion: nil)
  }

  @objc func viewAllButtonPressed() {
    let listings = ListingsVC()
    listings.modalPresentationStyle = .fullScreen
    present(listings, animated: true, completion: nil)
  }

  
}

// MARK: - Extensions

extension ProfileVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 1+(user.listings?.count ?? 0)
    return 15+1 /* use code above when firebase has data in it  */
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      if (collectionView == mediaUploadView.thumbnailImageCV) {
          if indexPath.item == 0 {
              if let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.addContentCell.rawValue, for: indexPath) as? AddContentCVCell {
                  return firstCell
              }
          } else {
             if let subsequentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue, for: indexPath) as? ListingCVCell {
              subsequentCell.aptThumbnail.image = UIImage(systemName: "bed.double")
              return subsequentCell
        }
      }
    return UICollectionViewCell()
    }
  }


//extension ProfileVC: UICollectionViewDelegate {
//   func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//         if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
//             collectionView.deselectItem(at: indexPath, animated: true)
//           let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
//             return false
//        }
//    return false
//  }
//}

extension ProfileVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.item == 0 {
        let createVC = CreateListingVC()
        createVC.modalPresentationStyle = .fullScreen
        present(createVC, animated: true, completion: nil)
    } /*else {
        let detailListingVC = DetailListingVC()
        present(detailListingVC, animated: true, completion: nil)
    }*/
  }
}


extension ProfileVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let cellSize = CGSize(width: (view.frame.width) * 0.3, height: (view.frame.width) * 0.3)
        return cellSize
    }
}
