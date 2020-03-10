//
//  AppUser.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import Foundation

public class AppUser: Codable {
    var id: String?
    var name: String?
    var email: String?
    var phone: String?
    var agency: String?
    var license: String?
    var bio: String?
    var profilePic: Data? /* will we store as data or string? */
    var location: String?
    var libraryPermission: Bool = false
  //let userType: UserType
    var listings: [ListingWrapper]?
  
  var fieldsDict: [String: Any] {
      return [
          "email": self.email ?? ""
      ]
  }
}

public class ListingWrapper: Codable {
  var id: String?
  var addresss: String?
  var price: String?
}



