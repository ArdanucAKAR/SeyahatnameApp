//
//  Travel.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 6.01.2021.
//

import Foundation
import MapKit

class Travel {
    var Name: String
    var Coordinate: CLLocationCoordinate2D
    var By: String

    init(name: String, coordinate: CLLocationCoordinate2D, by: String) {
        Name = name
        Coordinate = coordinate
        By = by
    }
}
