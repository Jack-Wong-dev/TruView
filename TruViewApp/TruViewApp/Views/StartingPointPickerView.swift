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
        addSubview(startingPointLabel)
        addSubview(startingPointPV)
    }
    
    private func addConstraints() {
       constrainStartPointlabel()
        constrainStartPointPV()
    }
    
    // MARK: - Constraint Methods
    private func constrainStartPointlabel() {
        startingPointLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), startingPointLabel.leadingAnchor.constraint(equalTo: leadingAnchor), startingPointLabel.trailingAnchor.constraint(equalTo: trailingAnchor), startingPointLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)].forEach({$0.isActive = true})
    }
    
    private func constrainStartPointPV() {
        startingPointPV.translatesAutoresizingMaskIntoConstraints = false
        
        [startingPointPV.centerXAnchor.constraint(equalTo: centerXAnchor), startingPointPV.centerYAnchor.constraint(equalTo: centerYAnchor), startingPointPV.widthAnchor.constraint(equalTo: widthAnchor), startingPointPV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)].forEach({$0.isActive = true})
    }
}
