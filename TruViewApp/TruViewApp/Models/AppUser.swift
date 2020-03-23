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

public class AppUser: Codable {
    var id: String
    var name: String?
    var email: String?
    var phone: String?
    var agency: String?
    var license: String?
    var bio: String?
    var profilePic: String? /* will we store as data or string? */
    var location: String?
    var libraryPermission: Bool = false
    var dateCreated: Date?
    var listings: [ListingWrapper]?
  
  init(from user: User) {
      self.id = user.uid
      self.name = user.displayName
      self.email = user.email
      self.phone = user.phoneNumber
      self.dateCreated = user.metadata.creationDate
      self.profilePic = user.photoURL?.absoluteString
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
        "location": self.location ?? "",
        "libraryPermission": self.libraryPermission,
        "listings": self.listings ?? []
      ]
  }
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



