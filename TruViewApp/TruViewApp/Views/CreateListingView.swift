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
    }
    
    private func addConstraints() {
        constrainPurchaseTypeSegControl()
    }
    
    private func setUpViewUI() {
        backgroundColor = .white
    }
    
    // MARK: - Constraint Methods
    private func constrainPurchaseTypeSegControl() {
        purchaseTypeSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [purchaseTypeSegController.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), purchaseTypeSegController.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.92), purchaseTypeSegController.centerXAnchor.constraint(equalTo: centerXAnchor), purchaseTypeSegController.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04)].forEach({$0.isActive = true})
    }
    
}
