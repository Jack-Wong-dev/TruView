//
//  Listing.swift
//  TruViewApp
//
//  Created by Jack Wong on 3/3/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import Foundation

struct Listing {
    let streetAdress: String
    let city: String
    let state: String
    let zipcode: Int
    let country: String
    
    static let allListings = [Listing(streetAdress: "1133 Park Place", city: "Brooklyn", state: "New York", zipcode: 11213, country: "USA"), Listing(streetAdress: "760 Prospect Place", city: "Brooklyn", state: "New York", zipcode: 11216, country: "USA"), Listing(streetAdress: "1650 Bedford Avenue", city: "Brooklyn", state: "New York", zipcode: 11225, country: "USA"), Listing(streetAdress: "880 Bergen Street", city: "Brooklyn", state: "New York", zipcode: 11238, country: "USA"), Listing(streetAdress: "1350 St. Johns Place", city: "Brooklyn", state: "New York", zipcode: 11213, country: "USA")
]
}

class AllListingData {
    
   static var listingCollection = [Listing]()
    
    func addListingData(data: Listing){
     AllListingData.listingCollection.append(data)
    }
    
}
