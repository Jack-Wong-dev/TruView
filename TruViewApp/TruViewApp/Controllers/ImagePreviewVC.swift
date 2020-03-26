//
//  ImagePreviewVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/26/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ImagePreviewVC: UIViewController {
    
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
    lazy var cancelButton: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(systemName: "xmark.circle.fill")
        imgVw.tintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        imgVw.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        imgVw.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imgVw.layer.shadowOpacity = 1.0
        imgVw.layer.shadowRadius = 0.0
        imgVw.layer.masksToBounds = false
        imgVw.layer.cornerRadius = 4.0
        return imgVw
    }()
    
    lazy var saveButton: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(systemName: "checkmark.circle.fill")
        imgVw.tintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        imgVw.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        imgVw.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imgVw.layer.shadowOpacity = 1.0
        imgVw.layer.shadowRadius = 0.0
        imgVw.layer.masksToBounds = false
        imgVw.layer.cornerRadius = 4.0
        return imgVw
    }()
    
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
        loadTapGestures()
    }
    
    // MARK: - Actions
    @objc func savePressed() {
        showAlert()
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(previewImageView)
        previewImageView.addSubview(cancelButton)
        previewImageView.addSubview(saveButton)
    }
    
    private func addConstraints() {
        constrainPreviewImageView()
        constrainCancelButton()
        constrainSaveButton()
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    private func loadTapGestures() {
        let cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelPressed))
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addGestureRecognizer(cancelTapGesture)
        
        let saveTapGesture = UITapGestureRecognizer(target: self, action: #selector(savePressed))
        saveButton.isUserInteractionEnabled = true
        saveButton.addGestureRecognizer(saveTapGesture)
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
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: previewImageView.safeAreaLayoutGuide.topAnchor, constant: view.frame.width * 0.04), cancelButton.leadingAnchor.constraint(equalTo: previewImageView.leadingAnchor, constant: view.frame.width * 0.04), cancelButton.widthAnchor.constraint(equalTo: previewImageView.widthAnchor, multiplier: 0.135), cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        [saveButton.topAnchor.constraint(equalTo: previewImageView.safeAreaLayoutGuide.topAnchor, constant: view.frame.width * 0.04), saveButton.trailingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: -(view.frame.width * 0.04)), saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor), saveButton.heightAnchor.constraint(equalTo: saveButton.widthAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPreviewImageView() {
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [previewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), previewImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

}
