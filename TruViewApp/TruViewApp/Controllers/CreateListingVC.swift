//
//  CreateListingVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class CreateListingVC: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return [.portrait, .portraitUpsideDown]
        }
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
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
        view.streetAddressTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.cityTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.stateTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.zipcodeTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.purchaseTypeSegController.addTarget(self, action: #selector(purchaseTypeSegmentControlPressed), for: .allEvents)
        view.sqFootageTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.priceTextField.addTarget(self, action: #selector(formValidationFor(textfield:)), for: .editingChanged)
        view.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    lazy var svContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
    
    let roomNamesForTour = ["classroom2", "flexspace", "bioshock", "tv"]
    var purchaseType: PurchaseType = .forSale

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
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
    
    @objc func formValidationFor(textfield: UITextField) {
        guard textfield.hasText else {
            Utilities.styleHighlightedTextField(textfield)
            return
        }
    }
    
    @objc func saveButtonPressed() {
        guard let address = createListingView.streetAddressTextField.text, let city = createListingView.cityTextField.text, let state = createListingView.stateTextField.text, let zipcode = createListingView.zipcodeTextField.text, let sqFootage = createListingView.sqFootageTextField.text, let price = createListingView.priceTextField.text, let summary = createListingView.descriptionTextView.text else {return}
        guard address != "", city != "", state != "", zipcode != "", sqFootage != "", price != "", summary != "" else {
            showAlert(title: "Alert", message: "All fields must be filled out")
            return
        }
        print(purchaseType)
        
        if let numZipcode = Int(zipcode), let numSqFootage = Int(sqFootage), let numPrice = Int(price) {
            let selectedNumOfBedrooms = createListingView.numOfBedroomsSegController.selectedSegmentIndex
            let selectedNumOfBaths = createListingView.numOfBathsSegController.selectedSegmentIndex
            let createdListing = Listing(streetAddress: address, city: city, state: state, zipcode: numZipcode, purchaseType: purchaseType, numOfBeds: selectedNumOfBedrooms, numOfBaths: selectedNumOfBaths, squareFootage: numSqFootage, price: numPrice, summary: summary)
            let detailVC = DetailListingVC()
            detailVC.selectedListing = createdListing
            present(detailVC, animated: true, completion: nil)
        } else {
            showAlert(title: "Alert", message: "Please enter full numbers for zipcode, square footage and price fields.")
        }
    
    }
    
    @objc func purchaseTypeSegmentControlPressed() {
        switch createListingView.purchaseTypeSegController.selectedSegmentIndex {
        case 0:
            purchaseType = .forSale
        case 1:
            purchaseType = .forRent
        case 2:
            purchaseType = .roomShares
        default:
            print("There is something wrong with your purchase types")
        }
    }
    
    @objc func createTourButtonPressed(_ sender: AnyObject) {
        
        let graph = EditorGraphData.manager.populateGraph()
        let firstRoom = graph.getRoom(name: graph.firstRoomID!)
        let tourVC = TourEditorVC(graph: graph, room: firstRoom!)
    
        let actionSheet = UIAlertController(title: "Pick the starting point of the tour", message: "", preferredStyle: .actionSheet)

        let pickerView = UIPickerView()
        actionSheet.view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self

        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in

            tourVC.modalPresentationStyle = .fullScreen
            self.present(tourVC,animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        if let actionSheetView = actionSheet.view {
            let height: NSLayoutConstraint = NSLayoutConstraint(item: actionSheetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.37)
            actionSheet.view.addConstraint(height)
        }

        actionSheet.addAction(saveAction)
        actionSheet.addAction(cancelAction)

        if let popoverController = actionSheet.popoverPresentationController {
//            popoverController.sourceView = self.view
            popoverController.sourceView = sender as? UIView
//            popoverController.sourceRect = sender.bounds
        }

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
