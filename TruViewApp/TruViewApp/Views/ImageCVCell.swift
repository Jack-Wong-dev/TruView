//
//  ImageCVCell.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/25/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ImageCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    lazy var imageUploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
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
        addSubview(imageUploadImageView)
    }
    
    private func addConstraints() {
        constrainImageUploadImageView()
    }
    
    // MARK: - Constraint Methods
    private func constrainImageUploadImageView() {
        imageUploadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [imageUploadImageView.topAnchor.constraint(equalTo: topAnchor), imageUploadImageView.leadingAnchor.constraint(equalTo: leadingAnchor), imageUploadImageView.trailingAnchor.constraint(equalTo: trailingAnchor), imageUploadImageView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }
}
