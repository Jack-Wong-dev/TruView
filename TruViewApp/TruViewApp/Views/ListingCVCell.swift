//
//  ListingCVCell.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ListingCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
        lazy var aptThumbnail: UIImageView = {
            let imgView = UIImageView()
            imgView.tintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
            imgView.contentMode = .scaleAspectFit
            return imgView
        }()
        
        lazy var priceLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "$2000"
            lbl.textAlignment = .right
            lbl.font = UIFont(name: "BanglaSangamMN-Bold", size: 16)
            return lbl
        }()
        
        lazy var bedAndbathLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "2 Bed 2 Bath"
            lbl.font = UIFont(name: "BanglaSangamMN", size: 14)
            return lbl
        }()
        
        lazy var sqFootageLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "600 sq Feet"
            lbl.font = UIFont(name: "BanglaSangamMN", size: 14)
            return lbl
        }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(aptThumbnail)
        addSubview(priceLabel)
        addSubview(bedAndbathLabel)
        addSubview(sqFootageLabel)
    }
    
    private func addConstraints() {
        constrainThumbnailImage()
        constrainBedAndBathLabel()
        constrainSqFootageLabel()
        constrainPriceLabel()
    }
    
    // MARK: - Constraint Methods
    private func constrainThumbnailImage() {
        aptThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        [aptThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor), aptThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), aptThumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), aptThumbnail.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)].forEach({$0.isActive = true})
    }
    
    private func constrainBedAndBathLabel() {
        bedAndbathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [bedAndbathLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), bedAndbathLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), bedAndbathLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor), bedAndbathLabel.heightAnchor.constraint(equalTo: aptThumbnail.heightAnchor, multiplier: 0.2)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootageLabel() {
        sqFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageLabel.topAnchor.constraint(equalTo: bedAndbathLabel.bottomAnchor), sqFootageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), sqFootageLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor), sqFootageLabel.heightAnchor.constraint(equalTo: bedAndbathLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor), priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), priceLabel.heightAnchor.constraint(equalTo: bedAndbathLabel.heightAnchor)].forEach({$0.isActive = true})
    }
}
