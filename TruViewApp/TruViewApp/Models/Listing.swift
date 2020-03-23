//
//  Listing.swift
//  TruViewApp
//
//  Created by Jack Wong on 3/3/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import Foundation
import MapKit

struct CoverPhoto {
    let image: UIImage
}

struct TourPhoto {
    let image: UIImage
    let title: String
}

enum PurchaseType {
    case forRent
    case forSale
    case roomShares
}

struct Listing {
    let streetAddress: String
    let city: String
    let state: String
    let zipcode: Int
    let country: String = "USA"
    let purchaseType: PurchaseType
    let numOfBeds: Double
    let numOfBaths: Double
    let squareFootage: Int
    let price: Int
    let summary: String
//    let coverPhotos: [CoverPhoto]
//    let tourPhotos: [TourPhoto]
//    let floorPlan: Graph
    var formattedAddress: String {
        return "\(country)\(city)\(streetAddress)"
    }
    
    
}


