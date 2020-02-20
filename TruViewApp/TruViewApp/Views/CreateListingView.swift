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
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addConstraints()
        setUpViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(purchaseTypeSegController)
        addSubview(numOfBedroomsLabel)
        addSubview(numOfBedroomsSegController)
        addSubview(numOfBathsLabel)
        addSubview(numOfBathsSegController)
    }
    
    private func addConstraints() {
        constrainPurchaseTypeSegControl()
        constrainNumOfBedroomsLabel()
        constrainNumOfBedSegControl()
        constrainNumOfBathsLabel()
        constrainNumOfBathsSegControl()
    }
    
    private func setUpViewUI() {
        backgroundColor = .white
    }
    
    // MARK: - Constraint Methods
    private func constrainPurchaseTypeSegControl() {
        purchaseTypeSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [purchaseTypeSegController.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), purchaseTypeSegController.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.92), purchaseTypeSegController.centerXAnchor.constraint(equalTo: centerXAnchor), purchaseTypeSegController.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedroomsLabel() {
        numOfBedroomsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsLabel.topAnchor.constraint(equalTo: purchaseTypeSegController.bottomAnchor), numOfBedroomsLabel.widthAnchor.constraint(equalTo: purchaseTypeSegController.widthAnchor), numOfBedroomsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsLabel.heightAnchor.constraint(equalTo: purchaseTypeSegController.heightAnchor, multiplier: 2)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedSegControl() {
        numOfBedroomsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsSegController.topAnchor.constraint(equalTo: numOfBedroomsLabel.bottomAnchor), numOfBedroomsSegController.widthAnchor.constraint(equalTo: purchaseTypeSegController.widthAnchor), numOfBedroomsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsSegController.heightAnchor.constraint(equalTo: purchaseTypeSegController.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsLabel() {
        numOfBathsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsLabel.topAnchor.constraint(equalTo: numOfBedroomsSegController.bottomAnchor), numOfBathsLabel.widthAnchor.constraint(equalTo: purchaseTypeSegController.widthAnchor), numOfBathsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsLabel.heightAnchor.constraint(equalTo: purchaseTypeSegController.heightAnchor, multiplier: 2)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsSegControl() {
        numOfBathsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsSegController.topAnchor.constraint(equalTo: numOfBathsLabel.bottomAnchor), numOfBathsSegController.widthAnchor.constraint(equalTo: purchaseTypeSegController.widthAnchor), numOfBathsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsSegController.heightAnchor.constraint(equalTo: purchaseTypeSegController.heightAnchor)].forEach({$0.isActive = true})
    }
    
}
