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
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.createTourButton.addTarget(self, action: #selector(createTourButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false
    var imagesForPanoCV = AllRoomData.imageCollection {
        didSet{
            mediaUploadView.panoImageCV.reloadData()
        }
    }
    var imagesForThumbnailCV = AllRoomData.imageCollection {
        didSet {
            mediaUploadView.thumbnailImageCV.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
        checkPhotoLibraryAccess()
        delegation()
    }
    
    // MARK: - Actions
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createTourButtonPressed() {
        let startPointVC = StartingPointVC()
        startPointVC.modalPresentationStyle = .fullScreen
        present(startPointVC, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(mediaUploadView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    private func delegation() {
        mediaUploadView.thumbnailImageCV.delegate = self
        mediaUploadView.thumbnailImageCV.dataSource = self
        mediaUploadView.panoImageCV.delegate = self
        mediaUploadView.panoImageCV.dataSource = self
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
extension MediaUploadVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == mediaUploadView.thumbnailImageCV) {
            return imagesForThumbnailCV.count + 1
        } else if (collectionView == mediaUploadView.panoImageCV) {
            return imagesForPanoCV.count + 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == mediaUploadView.thumbnailImageCV) {
            if indexPath.item == 0 {
                if let firstThumbnailCell = mediaUploadView.thumbnailImageCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.addContentCell.rawValue, for: indexPath) as? AddContentCVCell {
                    return firstThumbnailCell
                }
            } else {
               if let subsequentThumbnailCells = mediaUploadView.thumbnailImageCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue, for: indexPath) as? ImageCVCell {
                subsequentThumbnailCells.imageUploadImageView.image = imagesForThumbnailCV[indexPath.row - 1].image
                return subsequentThumbnailCells
                }
            }
        } else if (collectionView == mediaUploadView.panoImageCV) {
            if indexPath.item == 0 {
                if let firstPanoCell = mediaUploadView.panoImageCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.addContentCell.rawValue, for: indexPath) as? AddContentCVCell {
                    return firstPanoCell
                }
            } else {
               if let subsequentPanoCells = mediaUploadView.panoImageCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue, for: indexPath) as? ImageCVCell {
                subsequentPanoCells.imageUploadImageView.image = imagesForPanoCV[indexPath.row - 1].image
                return subsequentPanoCells
                }
            }
        }
        
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            present(imgPicker, animated: true, completion: nil)
        }
    }

}

extension MediaUploadVC: UICollectionViewDelegate {}

extension MediaUploadVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
    }
}

extension MediaUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePreviewVC = ImagePreviewVC()
        if let image = info[.originalImage] as? UIImage {
            imagePreviewVC.currentImage = image
        }
        imagePreviewVC.delegate = self
        dismiss(animated: true) {
            imagePreviewVC.modalPresentationStyle = .fullScreen
            self.present(imagePreviewVC, animated: true, completion: nil)
        }
    }
}

extension MediaUploadVC: DataSendingProtocol {

    func sendDataToCreateListingVC(roomData: RoomData) {
        imagesForPanoCV.append(roomData)
    }


}
