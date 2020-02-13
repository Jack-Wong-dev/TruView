//
//  ListingsVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import MapKit

class ListingsVC: UIViewController {

    // MARK: - UI Objects
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    lazy var filterMenuButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Filter", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    lazy var mapListViewSegController: UISegmentedControl = {
        let items = ["Map View", "List View"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
//        sc.addTarget(self, action: #selector(segControlValueChanged(_:)), for: .valueChanged)
        return sc
    }()
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    lazy var listingView: ListingCVView = {
        let lv = ListingCVView()
        return lv
    }()
    
    lazy var slideCardView: SlideCardView = {
        let scv = SlideCardView()
        return scv
    }()
    
    // MARK: - Properties
    let slideCardHeight: CGFloat = 900
    var slideCardState: SlideCardState = .collapsed
    
    var collapsedslideCardViewTopConstraint: NSLayoutConstraint?
    var halfOpenSlideCardViewTopConstraint: NSLayoutConstraint?
    var fullScreenSlideCardTopConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpInitialVCViews()
    }
    
    // MARK: - Private Methods
    private func setUpInitialVCViews() {
        view.backgroundColor = .white
    }
    
    private func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(filterMenuButton)
        view.addSubview(mapListViewSegController)
        view.addSubview(mapView)
        view.addSubview(listingView)
        view.addSubview(slideCardView)
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainFilterMenuButton()
        constrainSegmentedController()
        constrainMapView()
        constrainListingView()
        constrainSlideCardView()
    }
    
    // MARK: - Constraint Methods
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825), searchBar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)].forEach({$0.isActive = true})
    }
    
    private func constrainFilterMenuButton() {
        filterMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        [filterMenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), filterMenuButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor), filterMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), filterMenuButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSegmentedController() {
        mapListViewSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [mapListViewSegController.topAnchor.constraint(equalTo: searchBar.bottomAnchor), mapListViewSegController.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapListViewSegController.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapListViewSegController.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.4)].forEach({$0.isActive = true})
    }
    
    private func constrainMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [mapView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor), mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainListingView() {
        listingView.translatesAutoresizingMaskIntoConstraints = false
        
        [listingView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor), listingView.leadingAnchor.constraint(equalTo: view.leadingAnchor), listingView.trailingAnchor.constraint(equalTo: view.trailingAnchor), listingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSlideCardView() {
        slideCardView.translatesAutoresizingMaskIntoConstraints = false
        
        [slideCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor), slideCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor), slideCardView.heightAnchor.constraint(equalToConstant: slideCardHeight)].forEach({$0.isActive = true})
        createSlideCardViewConstraints()
    }
    
    // MARK: - Constraint Methods to change Slide Card View
    private func createSlideCardViewConstraints() {
        collapsedslideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant:  -slideCardHeight + 400)
        collapsedslideCardViewTopConstraint?.isActive = false

        halfOpenSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        halfOpenSlideCardViewTopConstraint?.isActive = true

        fullScreenSlideCardTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        fullScreenSlideCardTopConstraint?.isActive = false
    }
    
    private func activateFullOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = true
        collapsedslideCardViewTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateHalfOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        collapsedslideCardViewTopConstraint?.isActive = true
        halfOpenSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateClosedSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        collapsedslideCardViewTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = true
    }


}
