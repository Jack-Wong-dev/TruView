//
//  MediaUploadVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/1/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class MediaUploadVC: UIViewController {

    // MARK: - UI Objects
    lazy var mediaUploadView: MediaUploadView = {
        let view = MediaUploadView()
        return view
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(mediaUploadView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    

}
