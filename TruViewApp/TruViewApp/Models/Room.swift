//  Room.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//
import UIKit
import SceneKit

public class Room{
    
    var name: String?
    var imageURL: String?
    var hotspots: [String:Hotspot]
    
    init() {
        self.hotspots = [String:Hotspot]()
    }
    
    func getHotspot(destinationName: String) -> Hotspot? {
        return hotspots[destinationName]
    }
}

public class Hotspot{
    var name: String?
    var destination: Room
    var coordinates: (Float, Float, Float)
    
    init() {
        self.destination = Room()
        self.coordinates = (0, 0, 0)
    }
    
    func updatePosition(newPosition: SCNVector3) {
        self.coordinates = (newPosition.x, newPosition.y, newPosition.z)
    }
}
