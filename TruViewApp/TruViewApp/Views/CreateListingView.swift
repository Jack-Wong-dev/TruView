//
//  CreateListingView.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class CreateListingView: UIView {

    // MARK: - UI objects
    lazy var streetAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Street Address"
        return label
    }()
    
    lazy var streetAddressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter street address"
        return tf
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        return label
    }()
    
    lazy var cityTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter city"
        return tf
    }()
    
    lazy var purchaseTypeSegController: UISegmentedControl = {
        let items = ["For Sale", "For Rent", "Room Shares"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var numOfBedroomsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Bedrooms"
        label.textColor = .gray
        return label
    }()
    
    lazy var numOfBedroomsSegController: UISegmentedControl = {
        let items = ["Studio", "1+", "2+", "3+", "4+", "5+"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var numOfBathsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Baths"
        label.textColor = .gray
        return label
    }()
    
    lazy var numOfBathsSegController: UISegmentedControl = {
        let items = ["Any", "1+", "2+", "3+", "4+", "5+"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var sqFootageTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Square Footage",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()
    
    lazy var priceTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Price",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()
    
    let collectionView: ListingCVView = {
        let cv = ListingCVView()
        return cv
    }()
    
    let createTourButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Tour", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubViews()
        addConstraints()
        setUpViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(streetAddressLabel)
        addSubview(streetAddressTextField)
        addSubview(cityLabel)
        addSubview(cityTextField)
        addSubview(purchaseTypeSegController)
        addSubview(numOfBedroomsLabel)
        addSubview(numOfBedroomsSegController)
        addSubview(numOfBathsLabel)
        addSubview(numOfBathsSegController)
        addSubview(sqFootageTextField)
        addSubview(priceTextField)
        addSubview(collectionView)
        addSubview(createTourButton)
        
    }
    
    private func addConstraints() {
        constrainStreetAddressLabel()
        constrainStreetAddressTextField()
        constrainCityLabel()
        constrainCityTextField()
        constrainPurchaseTypeSegControl()
        constrainNumOfBedroomsLabel()
        constrainNumOfBedSegControl()
        constrainNumOfBathsLabel()
        constrainNumOfBathsSegControl()
        constrainSqFootageTextField()
        constrainPriceTextField()
        constrainCollectionView()
        constrainCreateTourButton()
    }
    
    private func setUpViewUI() {
        backgroundColor = .white
    }
    
    // MARK: - Constraint Methods
    private func constrainStreetAddressLabel() {
        streetAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [streetAddressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: frame.height * 0.05), streetAddressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.92), streetAddressLabel.centerXAnchor.constraint(equalTo: centerXAnchor), streetAddressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04)].forEach({$0.isActive = true})
    }
    
    private func constrainStreetAddressTextField() {
        streetAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [streetAddressTextField.topAnchor.constraint(equalTo: streetAddressLabel.bottomAnchor), streetAddressTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), streetAddressTextField.centerXAnchor.constraint(equalTo: centerXAnchor), streetAddressTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [cityLabel.topAnchor.constraint(equalTo: streetAddressTextField.bottomAnchor), cityLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor), cityLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCityTextField() {
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor), cityTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), cityTextField.centerXAnchor.constraint(equalTo: centerXAnchor), cityTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPurchaseTypeSegControl() {
        purchaseTypeSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [purchaseTypeSegController.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: frame.height * 0.02), purchaseTypeSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), purchaseTypeSegController.centerXAnchor.constraint(equalTo: centerXAnchor), purchaseTypeSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedroomsLabel() {
        numOfBedroomsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsLabel.topAnchor.constraint(equalTo: purchaseTypeSegController.bottomAnchor), numOfBedroomsLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBedroomsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.3)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedSegControl() {
        numOfBedroomsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsSegController.topAnchor.constraint(equalTo: numOfBedroomsLabel.bottomAnchor), numOfBedroomsSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBedroomsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsLabel() {
        numOfBathsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsLabel.topAnchor.constraint(equalTo: numOfBedroomsSegController.bottomAnchor), numOfBathsLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBathsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.3)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsSegControl() {
        numOfBathsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsSegController.topAnchor.constraint(equalTo: numOfBathsLabel.bottomAnchor), numOfBathsSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBathsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootageTextField() {
        sqFootageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageTextField.topAnchor.constraint(equalTo: numOfBathsSegController.bottomAnchor, constant: frame.height * 0.05), sqFootageTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), sqFootageTextField.centerXAnchor.constraint(equalTo: centerXAnchor), sqFootageTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPriceTextField() {
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [priceTextField.topAnchor.constraint(equalTo: sqFootageTextField.bottomAnchor, constant: frame.height * 0.05), priceTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), priceTextField.centerXAnchor.constraint(equalTo: centerXAnchor), priceTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        [collectionView.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: frame.height * 0.05), collectionView.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), collectionView.centerXAnchor.constraint(equalTo: centerXAnchor), collectionView.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 2.5)].forEach({$0.isActive = true})
    }
    
    private func constrainCreateTourButton() {
        createTourButton.translatesAutoresizingMaskIntoConstraints = false
        
        [createTourButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: frame.height * 0.05), createTourButton.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), createTourButton.centerXAnchor.constraint(equalTo: centerXAnchor), createTourButton.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.25)].forEach({$0.isActive = true})
    }
    
}
