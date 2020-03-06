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
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return view
    }()
    
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
    
    @objc func nextButtonPressed() {
        let graph = GraphData.manager.populateGraph()
        let startingRoom = graph.getRoom(name: graph.firstRoomID!)!
        let tourEditorVC = TourEditorVC(graph: graph, room: startingRoom)
        tourEditorVC.modalPresentationStyle = .fullScreen
        present(tourEditorVC, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(startPointView)
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    

}
