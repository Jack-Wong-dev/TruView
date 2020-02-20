//
//  CreateListingVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class CreateListingVC: UIViewController {
    
    // MARK: - UI Objects
    let createListingView: CreateListingView = {
        let view = CreateListingView()
        return view
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpVCViews()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(createListingView)
    }
    
    private func addConstraints() {
        constrainCreateListingView()
    }
    
    private func setUpVCViews() {
        view.backgroundColor = .white
    }
    
    // MARK: - Constraint Methods
    private func constrainCreateListingView() {
        createListingView.translatesAutoresizingMaskIntoConstraints = false
        
        [createListingView.topAnchor.constraint(equalTo: view.topAnchor), createListingView.leadingAnchor.constraint(equalTo: view.leadingAnchor), createListingView.trailingAnchor.constraint(equalTo: view.trailingAnchor), createListingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    
    

    
}
