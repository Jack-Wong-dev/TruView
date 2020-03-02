//
//  StartingPointVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 3/2/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class StartingPointVC: UIViewController {

    // MARK: - UI Objects
    lazy var startPointView: StartingPointPickerView = {
        let view = StartingPointPickerView()
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
        view.addSubview(startPointView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    

}
