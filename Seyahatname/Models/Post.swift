//
//  Post.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import Foundation

class Post {
    var ID: String
    var By: String
    var Image: String
    var Description: String
    var Likes: [String]
    var Latitude: Double
    var Longitude: Double

    init(id: String, by: String, image: String, description: String, likes: [String], latitude: Double, longitude: Double) {
        ID = id
        By = by
        Image = image
        Description = description
        Likes = likes
        Latitude = latitude
        Longitude = longitude
    }
}
