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
  //let userType: UserType
    var listings: [ListingWrapper]?
  
  init(from user: User) {
      self.id = user.uid
      self.name = user.displayName
      self.email = user.email
      self.phone = user.phoneNumber
      self.dateCreated = user.metadata.creationDate
      self.profilePic = user.photoURL?.absoluteString
  }
  
//  enum CodingKeys: String, CodingKey {
//    case email
//    case name
//    case phone
//    case agency
//    case license
//    case bio
//    case profilePic
//    case location
//    case libraryPermission
//    case listings
//  }
  
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
  
//  required public init(from decoder: Decoder) throws {
//    let values  = try decoder.container(keyedBy: CodingKeys.self)
//    self.email = try values.decode(String.self, forKey: .email)
//    self.name = try values.decode(String.self, forKey: .name)
//    self.phone = try values.decode(String.self, forKey: .phone)
//    self.agency = try values.decode(String.self, forKey: .agency)
//    self.license = try values.decode(String.self, forKey: .license)
//    self.bio = try values.decode(String.self, forKey: .bio)
//    self.profilePic = try values.decode(String.self, forKey: .profilePic)
//    self.location = try values.decode(String.self, forKey: .location)
//    self.libraryPermission = try values.decode(Bool.self, forKey: .libraryPermission)
//    self.listings = try values.decode([ListingWrapper].self, forKey: .listings)
//  }
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



