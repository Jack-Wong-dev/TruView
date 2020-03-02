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
        return cv
    }()
    
    lazy var startingPointLabel: UILabel = {
        let label = UILabel()
        label.text = "CHOOSE STARTING POINT OF THE TOUR"
        label.textAlignment = .center
        return label
    }()
    
    lazy var startingPointPV: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .black
        return pv
    }()
    
    lazy var panoImageCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
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
        addSubview(startingPointLabel)
        addSubview(startingPointPV)
        addSubview(panoImageCV)
    }
    
    private func addConstraints() {
        constrainThumbnailCV()
        constrainStartingPointLabel()
        constrainPickerView()
        constrainPanoCV()
    }
    
    // MARK: - Constriant Methods
    private func constrainThumbnailCV() {
        thumbnailImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [thumbnailImageCV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), thumbnailImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), thumbnailImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), thumbnailImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainStartingPointLabel() {
        startingPointLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointLabel.topAnchor.constraint(equalTo: thumbnailImageCV.bottomAnchor), startingPointLabel.leadingAnchor.constraint(equalTo: leadingAnchor), startingPointLabel.trailingAnchor.constraint(equalTo: trailingAnchor), startingPointLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)].forEach({$0.isActive = true})
    }
    
    private func constrainPickerView() {
        startingPointPV.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointPV.topAnchor.constraint(equalTo: startingPointLabel.bottomAnchor), startingPointPV.leadingAnchor.constraint(equalTo: leadingAnchor), startingPointPV.trailingAnchor.constraint(equalTo: trailingAnchor), startingPointPV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainPanoCV() {
        panoImageCV.translatesAutoresizingMaskIntoConstraints = false
        
        [panoImageCV.topAnchor.constraint(equalTo: startingPointPV.bottomAnchor), panoImageCV.leadingAnchor.constraint(equalTo: leadingAnchor), panoImageCV.trailingAnchor.constraint(equalTo: trailingAnchor), panoImageCV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
}
