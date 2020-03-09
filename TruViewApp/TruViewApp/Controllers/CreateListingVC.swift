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
        let sv = UIScrollView(frame: .zero)
        sv.frame = self.view.bounds
        sv.contentSize = svContentSize
        sv.autoresizingMask = .flexibleHeight
        return sv
    }()
    
    lazy var createListingView: CreateListingView = {
        let view = CreateListingView()
        view.frame.size = svContentSize
        view.manageCoverPhotosButton.addTarget(self, action: #selector(manageCoverPhotosBtnPressed), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    lazy var svContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)

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
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func manageCoverPhotosBtnPressed() {
        let coverPhtsVC = CoverPhotoManagerVC()
        coverPhtsVC.modalPresentationStyle = .fullScreen
        present(coverPhtsVC, animated: true, completion: nil)
    }
    @objc func createTourButtonPressed() {
//        let mediaUploadVC = MediaUploadVC()
//        mediaUploadVC.modalPresentationStyle = .fullScreen
//        present(mediaUploadVC, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(createListingView)
    }
    
    private func setUpVCViews() {
        view.backgroundColor = .systemBackground
    }
    
}

