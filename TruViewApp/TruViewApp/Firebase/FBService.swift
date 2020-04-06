
import Foundation
import FirebaseFirestore


fileprivate enum FireStoreCollections: String {
    case users
    case listings
    case graphs
    case rooms
    case hotspots
}


enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}


class FBService {
    static let manager = FBService()

    private let db = Firestore.firestore()

  
  
//MARK: AppUsers
func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
    var fields = user.fieldsDict
    fields["dateCreated"] = Date()
    db.collection(FireStoreCollections.users.rawValue).document(user.id).setData(fields) { (error) in
        if let error = error {
            completion(.failure(error))
            print(error)
        }
        completion(.success(()))
    }
}

  func updateCurrentUser(name: String? = nil, email: String? = nil, phone: String? = nil, agency: String? = nil, license: String? = nil, profilePic: Data?, bio: String? = nil, libraryPermission: Bool, completion: @escaping (Result<(), Error>) -> ()){
      guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
          return
      }
      var updateFields = [String:Any]()
      
      if let userName = name {
          updateFields["name"] = userName
      }
      if let userEmail = email {
          updateFields["email"] = userEmail
      }
      if let userPhone = phone {
          updateFields["phone"] = userPhone
      }
      if let userAgency = agency {
          updateFields["agency"] = userAgency
      }
      if let userLicense = license {
          updateFields["license"] = userLicense
      }
      if let userBio = bio {
          updateFields["bio"] = userBio
      }
      if let userProfilePic = profilePic {
          updateFields["profilePic"] = userProfilePic
      }
  db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
          if let error = error {
              completion(.failure(error))
          } else {
              completion(.success(()))
          }
      }
  }
  


  
  func getUserInfo(userEmail: String, completion: @escaping (Result<AppUser, Error>) -> ()) {
    guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
        return
    }
    

      db.collection(FireStoreCollections.users.rawValue).whereField("email", isEqualTo: userEmail).getDocuments { (snapshot, error) in
        let appUser = AppUser.self
          if let error = error {
              completion(.failure(error))
          } else {
            if let snapDoc = snapshot?.documents {
              let data = snapDoc.first?.data()
              if let name = data?["name"] as? String, let email = data?["email"] as? String, let phone = data?["phone"] as? String, let agency = data?["agency"] as? String, let license = data?["license"] as? String {
//                appUser.name = name
//                appUser?.email = email
//                appUser?.phone = phone
//                appUser?.agency = agency
//                appUser?.license = license
                }
            }
//            completion(.success(appUser))
          }
        }
      }

private init () {}

}
