//
//  FBService.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

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

func updateCurrentUser(name: String? = nil, email: String? = nil, phone: String? = nil, agency: String? = nil, license: String? = nil, bio: String? = nil, location: String? = nil, libraryPermission: Bool, completion: @escaping (Result<(), Error>) -> ()){
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
//      if let userProfilePic = profilePic {
//          updateFields["profilePic"] = userProfilePic
//      }
      if let userLocation = location {
          updateFields["location"] = userLocation
      }
  db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
          if let error = error {
              completion(.failure(error))
          } else {
              completion(.success(()))
          }
      }
  }
  
//  func getUser(userEmail: String, completion: @escaping (Result<AppUser, Error>) -> ()) {
//      db.collection(FireStoreCollections.users.rawValue).whereField("email", isEqualTo: userEmail).getDocuments { (snapshot, error) in
//          if let error = error {
//              completion(.failure(error))
//          } else {
//              let appUser = snapshot?.documents.compactMap({ (snapshot) -> AppUser? in
//                  let appUserID = snapshot.documentID
//                  let user = AppUser(from: snapshot.data(), id: appUserID)
//                  return user
//              })
//              completion(.success(appUser ?? []))
//          }
//      }
//  }

    private init () {}
}
