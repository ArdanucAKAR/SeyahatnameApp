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
//    var Date: Timestamp
    var Likes: Int

    init(postID: String, postBy: String, image: String, description: String, /* date: Timestamp, */ likes: Int) {
        PostID = postID
        PostBy = postBy
        Image = image
        Description = description
//        Date = date
        Likes = likes
    }
}
