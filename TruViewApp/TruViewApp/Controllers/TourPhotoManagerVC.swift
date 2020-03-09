//
//  TourPhotoManagerVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/8/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class TourPhotoManagerVC: UIViewController {

    // MARK: - UI Objects
    lazy var tourPhtMngrView: TourPhotoManagerView = {
        let view = TourPhotoManagerView()
        return view
    }()
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCView()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(tourPhtMngrView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .systemBackground
    }

}
