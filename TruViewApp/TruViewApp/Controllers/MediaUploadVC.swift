//
//  MediaUploadVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/1/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import Photos

class MediaUploadVC: UIViewController {

    // MARK: - UI Objects
    lazy var mediaUploadView: MediaUploadView = {
        let view = MediaUploadView()
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false
    var imagesForPanoCV = AllRoomData.imageCollection {
        didSet{
            mediaUploadView.panoImageCV.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
        checkPhotoLibraryAccess()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(mediaUploadView)
    }
    
    private func setUpVCView() {
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

// MARK: - Extensions
extension CreateListingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePreviewVC = ImagePreviewVC()
        if let image = info[.originalImage] as? UIImage {
            imagePreviewVC.currentImage = image
        }
//        imagePreviewVC.delegate = self
        dismiss(animated: true) {
            self.present(imagePreviewVC, animated: true, completion: nil)
        }
    }
}
