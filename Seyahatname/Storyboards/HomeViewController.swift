//
//  HomeViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Firebase
import SDWebImage
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tblPosts: UITableView!

    var Posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblPosts.delegate = self
        tblPosts.dataSource = self

        GetPosts()
    }

    func GetPosts() {
        let db = Firestore.firestore()

        db.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true, snapshot != nil {
                    self.Posts.removeAll()
                    for document in snapshot!.documents {
                        let data = document.data()
                        let post = Post(postID: document.documentID,
                                        postBy: data["postBy"] as! String,
                                        image: data["imageUrl"] as! String,
                                        description: data["description"] as! String,
//                                        date: data["date"] as! Timestamp,
                                        likes: data["likes"] as! Int)
                        self.Posts.append(post)
                    }
                    self.tblPosts.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPosts.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostsCell
        cell.lblUsername.text = Posts[indexPath.row].PostBy
        cell.lblDescription.text = Posts[indexPath.row].Description
        cell.lblLikeCount.text = String(Posts[indexPath.row].Likes)
        cell.imgPlace.sd_setImage(with: URL(string: Posts[indexPath.row].Image))
        cell.lblPostID.text = Posts[indexPath.row].PostID 
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 374
    }
}
