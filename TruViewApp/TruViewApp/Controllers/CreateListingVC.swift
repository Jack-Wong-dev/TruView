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
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    lazy var createListingView: CreateListingView = {
        let view = CreateListingView()
        view.uploadPhotosButton.addTarget(self, action: #selector(createTourButtonPressed), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCViews()
        addConstraints()
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
        view.addSubview(scrollView)
        scrollView.addSubview(createListingView)
    }
    
    private func setUpVCViews() {
        view.backgroundColor = .white
    }
    
    private func addConstraints() {
        constrainScrollView()
        constrainCreateListingView()
    }
    
    // MARK: - Constraint Methods
    private func constrainCreateListingView() {
        createListingView.translatesAutoresizingMaskIntoConstraints = false
        
        [createListingView.topAnchor.constraint(equalTo: scrollView.topAnchor), createListingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor), createListingView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor), createListingView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), createListingView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        [scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor), scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 1.5)
    }
    
}

