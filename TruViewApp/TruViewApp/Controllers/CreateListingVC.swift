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
        view.manageTourPhotosButton.addTarget(self, action: #selector(manageTourPhotosBtnPressed), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.createTourButton.addTarget(self, action: #selector(createTourButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    lazy var svContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
    
    let roomNamesForTour = ["classroom2", "flexspace", "bioshock", "tv"]

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
    
    @objc func manageTourPhotosBtnPressed() {
        let tourPhtsVC = TourPhotoManagerVC()
        tourPhtsVC.modalPresentationStyle = .fullScreen
        present(tourPhtsVC, animated: true, completion: nil)
    }
    
    @objc func createTourButtonPressed() {
        let actionSheet = UIAlertController(title: "Pick the starting point of the tour", message: "", preferredStyle: .actionSheet)
        
        let pickerView = UIPickerView()
        actionSheet.view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        if let actionSheetView = actionSheet.view {
            let height: NSLayoutConstraint = NSLayoutConstraint(item: actionSheetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.37)
            actionSheet.view.addConstraint(height)
        }
        
        actionSheet.addAction(saveAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: false) {
            pickerView.frame.size.width = actionSheet.view.frame.size.width
        }
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

// MARK: - Extensions
extension CreateListingVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roomNamesForTour.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roomNamesForTour[row]
    }
    
    
}

extension CreateListingVC: UIPickerViewDelegate {}
