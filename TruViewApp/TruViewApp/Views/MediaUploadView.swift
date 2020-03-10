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
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var thumbnailImageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.layer.cornerRadius = 25
        cv.register(AddContentCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.addContentCell.rawValue)
        cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
        return cv
    }()
    
    lazy var panoImageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.layer.cornerRadius = 25
        cv.register(AddContentCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.addContentCell.rawValue)
        cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
        return cv
    }()
    
    lazy var createTourButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Tour", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .gray
        return button
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
        addSubview(cancelButton)
        addSubview(createTourButton)
        addSubview(thumbnailImageCV)
        addSubview(panoImageCV)
    }
    
    private func addConstraints() {
        constrainCancelButton()
        constrainCreateTourButton()
        constrainThumbnailCV()
        constrainPanoCV()
    }
    
    // MARK: - Constriant Methods
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor), cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
    }
    
    private func constrainThumbnailCV() {
        thumbnailImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [thumbnailImageCV.topAnchor.constraint(equalTo: cancelButton.bottomAnchor), thumbnailImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), thumbnailImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), thumbnailImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainPanoCV() {
        panoImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [panoImageCV.topAnchor.constraint(equalTo: thumbnailImageCV.bottomAnchor), panoImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), panoImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), panoImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainCreateTourButton() {
        createTourButton.translatesAutoresizingMaskIntoConstraints = false
        
        [createTourButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(frame.height * 0.01)), createTourButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.89), createTourButton.centerXAnchor.constraint(equalTo: centerXAnchor), createTourButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }
}
