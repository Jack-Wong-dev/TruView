//
//  MediaUploadView.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/1/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class MediaUploadView: UIView {

    // MARK: - UI Objects
    lazy var thumbnailImageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(AddContentCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.addContentCell.rawValue)
        cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
        return cv
    }()
    
    lazy var panoImageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(AddContentCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.addContentCell.rawValue)
        cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
        return cv
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(thumbnailImageCV)
        addSubview(panoImageCV)
    }
    
    private func addConstraints() {
        constrainThumbnailCV()
        constrainPanoCV()
    }
    
    // MARK: - Constriant Methods
    private func constrainThumbnailCV() {
        thumbnailImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [thumbnailImageCV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), thumbnailImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), thumbnailImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), thumbnailImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
    }
    
    private func constrainPanoCV() {
        panoImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [panoImageCV.topAnchor.constraint(equalTo: thumbnailImageCV.bottomAnchor), panoImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), panoImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), panoImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
    }
}
