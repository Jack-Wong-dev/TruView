//
//  SlideCardView.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class SlideCardView: UIView {

    // MARK: - UI Objects
    lazy var upArrowIndicator: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrowtriangle.up")
        img.tintColor = .black
        return img
    }()
    
    lazy var aptThumbnail: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "front")
        img.backgroundColor = .blue
        return img
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$2000"
        label.textAlignment = .right
        return label
    }()
    
    lazy var bedAndBathLabel: UILabel = {
        let label = UILabel()
        label.text = "Beds: 2 Baths: 1"
        return label
    }()
    
    lazy var sqFootageLabel: UILabel = {
        let label = UILabel()
        label.text = "700 Sq. Feet"
        return label
    }()
    
    lazy var aptDescriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.text = "This home is conveniently located near the L Line and is surrounded by plenty of great eateries. Note that offer is available for a limited time for qualified applicants. Please inquire for additional details. Includes The residence features furnished common areas, kitchen essentials, and a private terrace. It also includes a washer/dryer, high-speed Wi-Fi, monthly professional cleaning services, and AC. About the Neighborhood Located in the center of Williamsburg, this home is only a 7-minute walk to the L line and a 10-minute walk to the J, M, Z and G lines."
        txtView.font = UIFont(name: "Arial", size: 16)
        txtView.backgroundColor = .systemBackground
        return txtView
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
        addSubview(upArrowIndicator)
        addSubview(aptThumbnail)
        addSubview(priceLabel)
        addSubview(bedAndBathLabel)
        addSubview(sqFootageLabel)
        addSubview(aptDescriptionTextView)
    }
    
    private func addConstraints() {
        constrainArrowImage()
        constrainAptThumbnailImage()
        constrainBedAndBathlabel()
        constrainSqFootagelabel()
        constrainPricelabel()
        constrainAptTextView()
    }
    
    private func setUpViewUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }
    
    // MARK: - Constraint Methods
    private func constrainArrowImage() {
        upArrowIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        [upArrowIndicator.topAnchor.constraint(equalTo: topAnchor), upArrowIndicator.centerXAnchor.constraint(equalTo: centerXAnchor), upArrowIndicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.031), upArrowIndicator.widthAnchor.constraint(equalTo: upArrowIndicator.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptThumbnailImage() {
        aptThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        [aptThumbnail.topAnchor.constraint(equalTo: upArrowIndicator.bottomAnchor, constant: 10), aptThumbnail.leadingAnchor.constraint(equalTo: leadingAnchor), aptThumbnail.trailingAnchor.constraint(equalTo: trailingAnchor), aptThumbnail.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainBedAndBathlabel() {
        bedAndBathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [bedAndBathLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), bedAndBathLabel.leadingAnchor.constraint(equalTo: leadingAnchor), bedAndBathLabel.trailingAnchor.constraint(equalTo: centerXAnchor), bedAndBathLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootagelabel() {
        sqFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageLabel.topAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor), sqFootageLabel.leadingAnchor.constraint(equalTo: leadingAnchor), sqFootageLabel.trailingAnchor.constraint(equalTo: centerXAnchor), sqFootageLabel.heightAnchor.constraint(equalTo: bedAndBathLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPricelabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: centerXAnchor), priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor), priceLabel.bottomAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptTextView() {
        aptDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [aptDescriptionTextView.topAnchor.constraint(equalTo: centerYAnchor), aptDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor), aptDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85), aptDescriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }

}
