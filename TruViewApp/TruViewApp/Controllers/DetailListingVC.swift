//
//  DetailListingVC.swift
//  TruViewApp
//
//  Created by Ian Cervone on 3/10/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class DetailListingVC: UIViewController {

    // MARK: - UI Objects
    lazy var slideCardView: SlideCardView = {
        let scv = SlideCardView()
        return scv
    }()
    
    // MARK: Properties
    var selectedListing: Listing!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        constrainSlideCardView()
        setUpViews()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(slideCardView)
    }
    
    private func setUpViews() {
        slideCardView.priceLabel.text = "$\(selectedListing.price)"
        slideCardView.aptDescriptionTextView.text = selectedListing.summary
        
        if selectedListing.numOfBeds == 0 {
            slideCardView.bedAndBathLabel.text = "Studio, \(selectedListing.numOfBaths)"
        } else {
            slideCardView.bedAndBathLabel.text = "\(selectedListing.numOfBeds) Beds \(selectedListing.numOfBaths) Baths"
        }
        
        slideCardView.sqFootageLabel.text = "\(selectedListing.squareFootage) Square Feet"
    }
    
    private func constrainSlideCardView() {
        slideCardView.translatesAutoresizingMaskIntoConstraints = false
        
        [slideCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), slideCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor), slideCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor), slideCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    

    

}
