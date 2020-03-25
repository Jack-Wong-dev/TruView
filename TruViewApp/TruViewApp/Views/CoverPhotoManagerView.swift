//
//  CoverPhotoManagerView.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/8/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class CoverPhotoManagerView: UIView {

    // MARK: - UI Objects
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1), for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont(name: "BanglaSangamMN-Bold", size: 21)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    lazy var coverPhotoCV: UICollectionView = {
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
        button.setTitleColor(#colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1), for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont(name: "BanglaSangamMN-Bold", size: 21)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
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
        addSubview(coverPhotoCV)
        addSubview(uploadPhotoButton)
    }
    
    private func addConstraints() {
        constrainCancelButton()
        constrainThumbnailCV()
        constrainUploadPhotoButton()
    }
    
    // MARK: - Constriant Methods
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor), cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
    }
    
    private func constrainThumbnailCV() {
        coverPhotoCV.translatesAutoresizingMaskIntoConstraints = false
        
        [coverPhotoCV.topAnchor.constraint(equalTo: cancelButton.bottomAnchor), coverPhotoCV.leadingAnchor.constraint(equalTo: leadingAnchor), coverPhotoCV.trailingAnchor.constraint(equalTo: trailingAnchor), coverPhotoCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.85)].forEach({$0.isActive = true})
    }
    
    private func constrainUploadPhotoButton() {
        uploadPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        [uploadPhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(frame.height * 0.01)), uploadPhotoButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.89), uploadPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor), uploadPhotoButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }

}
