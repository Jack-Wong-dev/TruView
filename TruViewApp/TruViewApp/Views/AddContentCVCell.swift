//
//  AddContentCVCell.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/24/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class AddContentCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    lazy var addContentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.circle")
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
        addSubview(addContentImageView)
    }
    
    private func addConstraints() {
        constrainAddContentImageView()
    }
    
    // MARK: - Constraint Methods
    private func constrainAddContentImageView() {
        addContentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [addContentImageView.topAnchor.constraint(equalTo: topAnchor), addContentImageView.leadingAnchor.constraint(equalTo: leadingAnchor), addContentImageView.trailingAnchor.constraint(equalTo: trailingAnchor), addContentImageView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }
}
