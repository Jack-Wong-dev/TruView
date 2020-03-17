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
}

class AllListingData {
    
   static var listingCollection = [Listing]()
    
    func addListingData(data: Listing){
     AllListingData.listingCollection.append(data)
    }
    
}


let listing1 = Listing(streetAdress: "1133 Park Place", city: "Brooklyn", state: "New York", zipcode: 11213)
let listing2 = Listing(streetAdress: "760 Prospect Place", city: "Brooklyn", state: "New York", zipcode: 11216)
let listing3 = Listing(streetAdress: "1650 Bedford Avenue", city: "Brooklyn", state: "New York", zipcode: 11225)
let listing4 = Listing(streetAdress: "880 Bergen Street", city: "Brooklyn", state: "New York", zipcode: 11238)
let listing5 = Listing(streetAdress: "1350 St. Johns Place", city: "Brooklyn", state: "New York", zipcode: 11213)
