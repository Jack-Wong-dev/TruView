//
//  TourPhotoManagerView.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/8/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class TourPhotoManagerView: UIView {

    // MARK: - UI Objects
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    lazy var tourPhotoCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.layer.cornerRadius = 25
        cv.register(ImageCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue)
        return cv
    }()
    
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload Photo", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemBackground
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
        addSubview(tourPhotoCV)
        addSubview(uploadPhotoButton)
    }
    
    private func addConstraints() {
        constrainCancelButton()
        constrainTourPhotoCV()
        constrainUploadPhotoButton()
    }
    
    // MARK: - Constriant Methods
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor), cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
    }
    
    private func constrainTourPhotoCV() {
        tourPhotoCV.translatesAutoresizingMaskIntoConstraints = false
        
        [tourPhotoCV.topAnchor.constraint(equalTo: cancelButton.bottomAnchor), tourPhotoCV.leadingAnchor.constraint(equalTo: leadingAnchor), tourPhotoCV.trailingAnchor.constraint(equalTo: trailingAnchor), tourPhotoCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.85)].forEach({$0.isActive = true})
    }
    
    private func constrainUploadPhotoButton() {
        uploadPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        [uploadPhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(frame.height * 0.01)), uploadPhotoButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.89), uploadPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor), uploadPhotoButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }

}
