//
//  ImagePreviewVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/26/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ImagePreviewVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var previewImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
    
    // MARK: - Properties
    weak var delegate: DataSendingProtocol?
    var currentRoomName: String?
    var currentImage: UIImage! {
        didSet {
            previewImageView.image = self.currentImage
        }
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpVCView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAlert()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(previewImageView)
    }
    
    private func addConstraints() {
        constrainPreviewImageView()
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Please enter room name.", message: "NOTE: All room names must be unique.", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
          let textField = alertController.textFields![0] as UITextField
            self.currentRoomName = textField.text
            if let unwrappedRoomName = self.currentRoomName {
                let currentRoomData = RoomData(image: self.currentImage, name: unwrappedRoomName)
                self.delegate?.sendDataToCreateListingVC(roomData: currentRoomData)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    
        alertController.addTextField { (textField) in
        textField.placeholder = "Enter the room name"
        }
    
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    
    
    }

    
    // MARK: - Constraint Methods
    private func constrainPreviewImageView() {
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [previewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), previewImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

}
