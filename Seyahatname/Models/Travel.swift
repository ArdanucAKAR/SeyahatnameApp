//
//  Travel.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 6.01.2021.
//

import Foundation
import MapKit

class Travel {
    var ID: String
    var Name: String
    var Coordinate: CLLocationCoordinate2D
    var By: String

    init(id: String, name: String, coordinate: CLLocationCoordinate2D, by: String) {
        ID = id
        Name = name
        Coordinate = coordinate
        By = by
    }
}
