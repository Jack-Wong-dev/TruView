//
//  SelectRoomViewController.swift
//  TestingCTPano
//
//  Created by Jack Wong on 2/24/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import UIKit

class FloorPlanVC: UIViewController {
    
    let roomSelectionView = FloorPlanView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(view: roomSelectionView)
        roomSelectionView.roomTableView.delegate = self
        roomSelectionView.roomTableView.dataSource = self
        roomSelectionView.roomTableView.tableFooterView = UIView()
    }
    
}

extension FloorPlanVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(roomSelectionView.allRooms.count)
        return roomSelectionView.allRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = roomSelectionView.roomTableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! RoomTableViewCell
        
        let selectedRoom = roomSelectionView.allRooms[indexPath.row]
        cell.configureCell(name: selectedRoom.name!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRoom = roomSelectionView.allRooms[indexPath.row]
        
        let editorVC = TourEditorVC(graph: roomSelectionView.selectedGraph, room: selectedRoom)
        
        editorVC.modalPresentationStyle = .fullScreen
        
        self.present(editorVC, animated: true, completion: nil)
    }
    
}




