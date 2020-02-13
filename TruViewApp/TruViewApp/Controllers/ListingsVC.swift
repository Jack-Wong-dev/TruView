//
//  ListingsVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import MapKit

class ListingsVC: UIViewController {

    // MARK: - UI Objects
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    lazy var filterMenuButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Filter", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    lazy var mapListViewSegController: UISegmentedControl = {
        let items = ["Map View", "List View"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
//        sc.addTarget(self, action: #selector(segControlValueChanged(_:)), for: .valueChanged)
        return sc
    }()
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
