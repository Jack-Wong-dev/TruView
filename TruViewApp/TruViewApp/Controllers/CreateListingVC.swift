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
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpVCViews()
        checkPhotoLibraryAccess()
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
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                case .authorized:
                    self?.photoLibraryAccessIsAuthorized = true
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                case .denied:
                    self?.photoLibraryAccessIsAuthorized = false
                @unknown default:
                    fatalError()
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            photoLibraryAccessIsAuthorized = false
        @unknown default:
            print("nothing should happen here")
        }
    }
    
    // MARK: - Constraint Methods
    private func constrainCreateListingView() {
        createListingView.translatesAutoresizingMaskIntoConstraints = false
        
        [createListingView.topAnchor.constraint(equalTo: view.topAnchor), createListingView.leadingAnchor.constraint(equalTo: view.leadingAnchor), createListingView.trailingAnchor.constraint(equalTo: view.trailingAnchor), createListingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    
    

    
}
