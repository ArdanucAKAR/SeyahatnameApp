//
//  Post.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import Firebase
import Foundation

class Post {
    var PostID: String
    var PostBy: String
    var Image: String
    var Description: String
    var Likes: Int
    var Latitude: Double
    var Longitude: Double

    init(postID: String, postBy: String, image: String, description: String, likes: Int, latitude: Double, longitude: Double) {
        PostID = postID
        PostBy = postBy
        Image = image
        Description = description
        Likes = likes
        Latitude = latitude
        Longitude = longitude
    }
}
