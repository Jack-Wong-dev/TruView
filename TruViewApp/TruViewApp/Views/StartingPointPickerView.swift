//
//  StartingPointPickerView.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/2/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class StartingPointPickerView: UIView {

    // MARK: - UI Objects
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        return button
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
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
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
        addSubview(startingPointLabel)
        addSubview(startingPointPV)
        addSubview(nextButton)
    }
    
    private func addConstraints() {
        constrainCancelButton()
        constrainStartPointlabel()
        constrainStartPointPV()
        constrainNextButton()
    }
    
    // MARK: - Constraint Methods
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor), cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)].forEach({$0.isActive = true})
    }
    
    private func constrainStartPointlabel() {
        startingPointLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor), startingPointLabel.leadingAnchor.constraint(equalTo: leadingAnchor), startingPointLabel.trailingAnchor.constraint(equalTo: trailingAnchor), startingPointLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
    }
    
    private func constrainStartPointPV() {
        startingPointPV.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointPV.centerXAnchor.constraint(equalTo: centerXAnchor), startingPointPV.centerYAnchor.constraint(equalTo: centerYAnchor), startingPointPV.widthAnchor.constraint(equalTo: widthAnchor), startingPointPV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
    
    private func constrainNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        [nextButton.topAnchor.constraint(equalTo: startingPointPV.bottomAnchor), nextButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.89), nextButton.centerXAnchor.constraint(equalTo: centerXAnchor), nextButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }
}
