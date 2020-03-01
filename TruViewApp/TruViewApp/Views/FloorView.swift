//
//  SelectViewModel.swift
//  TestingCTPano
//
//  Created by Jack Wong on 2/24/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import UIKit

class FloorPlanView : UIView {
    
    var selectedGraph = Graph() {
        didSet{
            var everyRoom = [Room]()
            for (_,room)in selectedGraph.floorPlan{
                everyRoom.append(room)
            }
            everyRoom.sort{ $0.name! < $1.name! }
            allRooms = everyRoom
        }
    }
    
    var allRooms = [Room]() {
        didSet{
            roomTableView.reloadData()
        }
    }
    
    lazy var firstRoomPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var roomTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: "roomCell")
        tableView.frame = frame
        return tableView
    }()
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
//    //MARK:-- Modified convenience init to take in a graph
//    public convenience init(frame: CGRect, graph: Graph) {
//        self.init(frame: frame)
//        selectedGraph = graph
//        // Force Swift to call the property observer by calling the setter from a non-init context
//        commonInit()
//    }
    
    private func commonInit() {
        add(view: roomTableView)
        populateGraph()
        setTableViewConstraints()
    }
    
    private func populateGraph(){
        selectedGraph = EditorGraphData.manager.populateGraph()
    }
    
}

extension FloorPlanView {
    
    private func setTableViewConstraints(){
        roomTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomTableView.topAnchor.constraint(equalTo: topAnchor),
            roomTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roomTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roomTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


