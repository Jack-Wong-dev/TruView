//
//  CreateListingVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import Photos

class CreateListingVC: UIViewController {
    
    // MARK: - UI Objects
    let createListingView: CreateListingView = {
        let view = CreateListingView()
        view.createTourButton.addTarget(self, action: #selector(createTourButtonPressed), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCViews()
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleTextField(createListingView.streetAddressTextField)
        Utilities.styleTextField(createListingView.cityTextField)
        Utilities.styleTextField(createListingView.stateTextField)
        Utilities.styleTextField(createListingView.zipcodeTextField)
        Utilities.styleTextField(createListingView.sqFootageTextField)
        Utilities.styleTextField(createListingView.priceTextField)
        Utilities.styleTextView(createListingView.descriptionTextView)
    }
    
    // MARK: - Actions
    @objc func createTourButtonPressed() {
        let mediaUploadVC = MediaUploadVC()
        mediaUploadVC.modalPresentationStyle = .fullScreen
        present(mediaUploadVC, animated: true, completion: nil)
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(createListingView)
    }
    
    private func setUpVCViews() {
        view.backgroundColor = .white
    }
    
}

