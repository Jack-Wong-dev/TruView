//
//  TourPhotoManagerVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/8/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import Photos

class TourPhotoManagerVC: UIViewController {

    // MARK: - UI Objects
    lazy var tourPhtMngrView: TourPhotoManagerView = {
        let view = TourPhotoManagerView()
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.uploadPhotoButton.addTarget(self, action: #selector(uploadPhotoButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false
    var usersTourPhtUploads = AllRoomData.imageCollection {
        didSet {
            tourPhtMngrView.tourPhotoCV.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
    }
    
    // MARK: - Actions
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func uploadPhotoButtonPressed() {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(tourPhtMngrView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .systemBackground
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
                    fatalError("This is outside of any authorization case.")
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

}

extension TourPhotoManagerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePreviewVC = ImagePreviewVC()
        if let image = info[.originalImage] as? UIImage {
            imagePreviewVC.currentImage = image
        }
//        imagePreviewVC.delegate = self
        dismiss(animated: true) {
            imagePreviewVC.modalPresentationStyle = .fullScreen
            self.present(imagePreviewVC, animated: true, completion: nil)
        }
    }
}
