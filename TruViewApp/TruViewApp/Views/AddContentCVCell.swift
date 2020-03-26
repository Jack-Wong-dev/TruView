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
        imageView.tintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
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
        
        [addContentImageView.centerYAnchor.constraint(equalTo: centerYAnchor), addContentImageView.centerXAnchor.constraint(equalTo: centerXAnchor),         addContentImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),addContentImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
].forEach({$0.isActive = true})
    }
}
