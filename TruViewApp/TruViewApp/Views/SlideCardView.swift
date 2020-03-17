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
    lazy var cardIndicatorImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "minus")
        img.tintColor = .systemGray
        return img
    }()
    
    lazy var aptThumbnail: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "front")
        img.backgroundColor = .systemBackground
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = false
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        return img
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$2000"
        label.textAlignment = .left
        label.font = UIFont(name: "BanglaSangamMN-Bold", size: 20)
        return label
    }()
    
    lazy var bedAndBathLabel: UILabel = {
        let label = UILabel()
        label.text = "Beds: 2 Baths: 1"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var sqFootageLabel: UILabel = {
        let label = UILabel()
        label.text = "700 Square Feet"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var contactAgentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Contact Agent", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    lazy var aptDescriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.text = "This home is conveniently located near the L Line and is surrounded by plenty of great eateries. Note that offer is available for a limited time for qualified applicants. Please inquire for additional details. Includes The residence features furnished common areas, kitchen essentials, and a private terrace. It also includes a washer/dryer, high-speed Wi-Fi, monthly professional cleaning services, and AC. About the Neighborhood Located in the center of Williamsburg, this home is only a 7-minute walk to the L line and a 10-minute walk to the J, M, Z and G lines."
        txtView.font = UIFont(name: "BanglaSangamMN", size: 16)
        txtView.backgroundColor = .systemBackground
        return txtView
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
        addSubview(cardIndicatorImage)
        addSubview(aptThumbnail)
        addSubview(contactAgentButton)
        addSubview(priceLabel)
        addSubview(bedAndBathLabel)
        addSubview(sqFootageLabel)
        addSubview(aptDescriptionTextView)
    }
    
    private func addConstraints() {
        constrainArrowImage()
        constrainAptThumbnailImage()
        constrainPricelabel()
        constrainBedAndBathlabel()
        constrainSqFootagelabel()
        constrainContactAgentBtn()
        constrainAptTextView()
    }
    
    private func setUpViewUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }
    
    // MARK: - Constraint Methods
    private func constrainArrowImage() {
        cardIndicatorImage.translatesAutoresizingMaskIntoConstraints = false
        
        [cardIndicatorImage.topAnchor.constraint(equalTo: topAnchor), cardIndicatorImage.centerXAnchor.constraint(equalTo: centerXAnchor), cardIndicatorImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.025), cardIndicatorImage.widthAnchor.constraint(equalTo: cardIndicatorImage.heightAnchor, multiplier: 3)].forEach({$0.isActive = true})
    }
    
    private func constrainAptThumbnailImage() {
        aptThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        [aptThumbnail.topAnchor.constraint(equalTo: cardIndicatorImage.bottomAnchor), aptThumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.height * 0.0075), aptThumbnail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(frame.height * 0.0075)), aptThumbnail.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainPricelabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor), priceLabel.trailingAnchor.constraint(equalTo: centerXAnchor), priceLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03)].forEach({$0.isActive = true})
    }
    
    private func constrainBedAndBathlabel() {
        bedAndBathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [bedAndBathLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor), bedAndBathLabel.leadingAnchor.constraint(equalTo: leadingAnchor), bedAndBathLabel.trailingAnchor.constraint(equalTo: centerXAnchor), bedAndBathLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootagelabel() {
        sqFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageLabel.topAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor), sqFootageLabel.leadingAnchor.constraint(equalTo: leadingAnchor), sqFootageLabel.trailingAnchor.constraint(equalTo: centerXAnchor), sqFootageLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainContactAgentBtn() {
        contactAgentButton.translatesAutoresizingMaskIntoConstraints = false
        
        [contactAgentButton.centerYAnchor.constraint(equalTo: priceLabel.bottomAnchor), contactAgentButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: frame.width * 0.009), contactAgentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(frame.width * 0.009)), contactAgentButton.heightAnchor.constraint(equalTo: priceLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptTextView() {
        aptDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [aptDescriptionTextView.topAnchor.constraint(equalTo: centerYAnchor), aptDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor), aptDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85), aptDescriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }

}
