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
    
    static let allListings = [Listing(streetAddress: "715 St Marks Ave", city: "Brooklyn", state: "NY", zipcode: 11216, purchaseType: .forRent, numOfBeds: 2, numOfBaths: 1, squareFootage: 900, price: 2200, summary: "Somebody probably loves this home?"), Listing(streetAddress: "1293 Dean Street", city: "Brooklyn", state: "NY", zipcode: 11216, purchaseType: .forRent, numOfBeds: 2, numOfBaths: 2, squareFootage: 500, price: 2100, summary: "Great Place!"), Listing(streetAddress: "1237 Dean Street", city: "Brooklyn", state: "NY", zipcode: 11216, purchaseType: .forRent, numOfBeds: 2, numOfBaths: 1, squareFootage: 900, price: 2200, summary: "Somebody probably loves this home?"), Listing(streetAddress: "247 Herkimer St", city: "Brooklyn", state: "NY", zipcode: 11216, purchaseType: .forRent, numOfBeds: 2, numOfBaths: 1, squareFootage: 900, price: 2200, summary: "Home Sweet Home")]
    
}
