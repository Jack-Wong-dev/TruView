//
//  CoverPhotoManagerVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/8/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import Photos

class CoverPhotoManagerVC: UIViewController {

    // MARK: - UI Objects
    lazy var coverPhtMngrView: CoverPhotoManagerView = {
        let view = CoverPhotoManagerView()
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.uploadPhotoButton.addTarget(self, action: #selector(uploadPhotoButtonPressed), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false
    var usersCoverPhtUploads = AllRoomData.imageCollection {
        didSet {
            coverPhtMngrView.coverPhotoCV.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
        cvDelegation()
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
        view.addSubview(coverPhtMngrView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .systemBackground
    }
    
    private func cvDelegation() {
        coverPhtMngrView.coverPhotoCV.delegate = self
        coverPhtMngrView.coverPhotoCV.dataSource = self
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
extension CoverPhotoManagerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension CoverPhotoManagerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if usersCoverPhtUploads.count == 0 {
            self.coverPhtMngrView.coverPhotoCV.setEmptyMessage("You have 0 media uploads")
        } else {
            self.coverPhtMngrView.coverPhotoCV.restore()
        }

        return usersCoverPhtUploads.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let upload = usersCoverPhtUploads[indexPath.row]
        if let cell = coverPhtMngrView.coverPhotoCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.imageUploadCell.rawValue, for: indexPath) as? ImageCVCell {
            cell.imageUploadImageView.image = upload.image
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CoverPhotoManagerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.8, height: view.frame.width * 0.8)
    }
}

extension CoverPhotoManagerVC: UICollectionViewDelegate {}

extension CoverPhotoManagerVC: DataSendingProtocol {

    func sendDataToCreateListingVC(roomData: RoomData) {
        usersCoverPhtUploads.append(roomData)
    }


}
