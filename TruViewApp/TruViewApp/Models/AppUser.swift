//
//  AppUser.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


struct AppUser: Codable {
    var id: String
    var name: String?
    var email: String?
    var phone: String?
    var agency: String?
    var license: String?
    var bio: String?
    var profilePic: Data?
    var libraryPermission: Bool = false
    var dateCreated: Date?
    var listings: [ListingWrapper]?
  
  init(from user: User) {
      self.id = user.uid
      self.name = user.displayName
      self.email = user.email
      self.phone = user.phoneNumber
      self.dateCreated = user.metadata.creationDate
//      self.profilePic = user.photoData
  }
  
  var fieldsDict: [String: Any] {
      return [
        "email": self.email ?? "",
        "name": self.name ?? "",
        "phone": self.phone ?? "",
        "agency": self.agency ?? "",
        "license": self.license ?? "",
        "bio": self.bio ?? "",
        "profilePic": self.profilePic ?? "",
        "libraryPermission": self.libraryPermission,
        "dateCreated": self.dateCreated ?? "",
        "listings": self.listings ?? []
      ]
  }
  
  init?(from dict: [String: Any], id: String) {
  guard let name = dict["name"] as? String,
      let email = dict["email"] as? String,
      let phone = dict["phone"] as? String,
      let agency = dict["agency"] as? String,
      let license = dict["license"] as? String,
      let photoData = dict["profilePic"] as? Data,
      let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
  
  self.id = id
  self.name = name
  self.email = email
  self.phone = phone
  self.agency = agency
  self.license = license
  self.dateCreated = dateCreated
  self.profilePic = photoData
  
  
}

public class ListingWrapper: Codable {
  var id: String?
  var address: String?
  var price: String?  
  var fieldsDict: [String: Any] {
  return [
    "id": self.id ?? "",
    "address": self.address ?? "",
    "price": self.price ?? ""
    ]
  }
}


}
