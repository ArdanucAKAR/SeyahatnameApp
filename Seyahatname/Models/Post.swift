//
//  Post.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import Foundation
import Firebase

class Post {
    var PostBy: String
    var Image: String
    var Description: String
//    var Date: Timestamp
    var Likes: Int

    init(postBy: String, image: String, description: String, /*date: Timestamp,*/ likes: Int) {
        PostBy = postBy
        Image = image
        Description = description
//        Date = date
        Likes = likes
    }
}
