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
    
    lazy var mapListViewSegController: UISegmentedControl = {
        let items = ["Map View", "List View"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        sc.addTarget(self, action: #selector(segControlValueChanged(_:)), for: .valueChanged)
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
    lazy var slideCardHeight: CGFloat = view.frame.height
    var slideCardState: SlideCardState = .collapsed
    
    private let locationManager = CLLocationManager()
    private let initialLocation = CLLocation(latitude: 40.742928, longitude: -73.941660)
    private let searchRadius: Double = 1000
    var listings = Listing.allListings
    var selectedListing: Listing?
    var searchString: String? {
        didSet {
            geocodeAddressFor(listings: listings)
        }
    }
    
    var halfOpenSlideCardViewTopConstraint: NSLayoutConstraint?
    var collapsedSlideCardViewTopConstraint: NSLayoutConstraint?
    var fullScreenSlideCardTopConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpInitialVCViews()
        delegation()
        loadGestures()
        locationAuthorization()
        geocodeAddressFor(listings: listings)
    }
    
    @objc func thumbnailTapped() {
        let panoVC = PanoVC()
        panoVC.modalPresentationStyle = .fullScreen
        
        present(panoVC, animated: true, completion: nil)
    }
    
    // MARK: - Objc Methods
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer?) {
        if let swipeGesture = gesture {
            switch swipeGesture.direction {
            case .down:
                switch slideCardState {
                case .fullOpen:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                case .halfOpen:
                    activateClosedSliderViewConstraints()
                    slideCardState = .collapsed
                case .collapsed:
                    print("Its closed already")
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                }, completion: nil)
            case .up:
                switch slideCardState {
                case .fullOpen:
                    print("Its already fully open")
                case .halfOpen:
                    activateFullOpenSliderViewConstraints()
                    slideCardState = .fullOpen
                case .collapsed:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                }, completion: nil)
                
            default:
                break
                
            }
        }
    }
    
    @objc func segControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showMapView()
        case 1:
            showListView()
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    private func setUpInitialVCViews() {
        view.backgroundColor = .systemBackground
        showMapView()
    }
    
    private func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(mapListViewSegController)
        view.addSubview(mapView)
        view.addSubview(listingView)
        view.addSubview(slideCardView)
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainSegmentedController()
        constrainMapView()
        constrainListingView()
        constrainSlideCardView()
    }
    
    private func delegation() {
        listingView.collectionView.delegate = self
        listingView.collectionView.dataSource = self
        locationManager.delegate = self
        mapView.delegate = self
        searchBar.delegate = self
    }
    
    private func loadGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.slideCardView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = .up
        self.slideCardView.addGestureRecognizer(swipeUp)
        
        let thumbnailTapGesture = UITapGestureRecognizer(target: self, action: #selector(thumbnailTapped))
        slideCardView.aptThumbnail.isUserInteractionEnabled = true
        slideCardView.aptThumbnail.addGestureRecognizer(thumbnailTapGesture)
    }
    
    private func showMapView() {
        mapView.isHidden = false
        slideCardView.isHidden = false
        listingView.isHidden = true
    }
    
    private func showListView() {
        listingView.isHidden = false
        slideCardView.isHidden = true
        mapView.isHidden = true
    }
    
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func geocodeAddressFor(listings: [Listing]) {
        
        for listing in listings {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(listing.formattedAddress) { [weak self] placemarks, error in
                
                if let placemark = placemarks?.first, let location = placemark.location {
                    
                    let annotation: MKPointAnnotation = {
                        let annotation = MKPointAnnotation()
                        annotation.title = "$\(listing.price)"
                        annotation.coordinate = location.coordinate
                        annotation.subtitle = "\(listing.streetAddress)"
                        return annotation
                    }()
                    
                    self?.mapView.addAnnotation(annotation)
                }
            }
        }
        
    }
    
    private func zoomMapOn(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: searchRadius * 2.0, longitudinalMeters: searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setUpSlideCardViews() {
        slideCardView.priceLabel.text = "$\(selectedListing?.price ?? 0)"
        slideCardView.bedAndBathLabel.text = "Beds: \(selectedListing?.numOfBeds ?? 0), Baths: \(selectedListing?.numOfBaths ?? 0)"
        slideCardView.aptDescriptionTextView.text = selectedListing?.summary
    }
    
    // MARK: - Constraint Methods
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSegmentedController() {
        mapListViewSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [mapListViewSegController.topAnchor.constraint(equalTo: searchBar.bottomAnchor), mapListViewSegController.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapListViewSegController.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapListViewSegController.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
    }
    
    private func constrainMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [mapView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor, constant: 5), mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
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
        halfOpenSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant:  -slideCardHeight / 1.9)
        halfOpenSlideCardViewTopConstraint?.isActive = false

        collapsedSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: slideCardHeight)
        collapsedSlideCardViewTopConstraint?.isActive = true

        fullScreenSlideCardTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        fullScreenSlideCardTopConstraint?.isActive = false
    }
    
    private func activateFullOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = true
        halfOpenSlideCardViewTopConstraint?.isActive = false
        collapsedSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateHalfOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = true
        collapsedSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateClosedSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = false
        collapsedSlideCardViewTopConstraint?.isActive = true
    }
}

// MARK: - Extensions
extension ListingsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = listingView.collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue, for: indexPath) as? ListingCVCell {
            cell.aptThumbnail.image = UIImage(systemName: "bed.double")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension ListingsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 175)
    }
}

extension ListingsVC: UICollectionViewDelegate {}

extension ListingsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.mapView.showsUserLocation = true
            zoomMapOn(location: location)
        }
        print("New locations: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occured: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
    
}

extension ListingsVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.pinTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let selectedAnnotation = UIButton(type: .roundedRect)
        view.detailCalloutAccessoryView = selectedAnnotation
        let selected = self.listings.filter({$0.streetAddress == view.annotation?.subtitle})
        selectedListing = selected.first
        setUpSlideCardViews()
        activateHalfOpenSliderViewConstraints()
        slideCardState = .halfOpen
    }
}

extension ListingsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            
            if response == nil {
                self.showAlert(title: "Alert", message: "We could not find any results matching you search")
            } else {
                //remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //add new annotations
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude ?? self.initialLocation.coordinate.latitude, longitude: longitude ?? self.initialLocation.coordinate.longitude)
            
                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius, longitudinalMeters: self.searchRadius)
                self.mapView.setRegion(coordinateRegion, animated: true)
//                self.currentLocation = .init(latitude: latitude ?? self.initialLocation.coordinate.latitude, longitude: longitude ?? self.initialLocation.coordinate.longitude)
//                
                
            }
        }
    }
}
