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
                print(error?.localizedDescription ?? "Bilinmeyen Hata")
            } else {
                if snapshot?.isEmpty != true, snapshot != nil {
                    self.Posts.removeAll()
                    for document in snapshot!.documents {
                        let data = document.data()
                        let post = Post(id: document.documentID,
                                        by: data["postBy"] as! String,
                                        image: data["imageUrl"] as! String,
                                        description: data["description"] as! String,
                                        likes: data["likes"] as! [String],
                                        latitude: data["latitude"] as! Double,
                                        longitude: data["longitude"] as! Double,
                                        thoseWhoWantToGo: data["thoseWhoWantToGo"] as! [String])
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

    func find(value searchValue: String, in array: [String]) -> String? {
        for (index, userID) in array.enumerated() {
            if userID == searchValue {
                return userID
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userID = (Auth.auth().currentUser?.uid)!
        let cell = tblPosts.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostsCell

        cell.vc = self
        cell.lblUsername.text = Posts[indexPath.row].By
        cell.lblDescription.text = Posts[indexPath.row].Description
        cell.lblLikeCount.text = String(Posts[indexPath.row].Likes.count)
        cell.imgPlace.sd_setImage(with: URL(string: Posts[indexPath.row].Image))
        cell.lblPostID.text = Posts[indexPath.row].ID
        cell.lblLatitude.text = "\(Posts[indexPath.row].Latitude)"
        cell.lblLongitude.text = "\(Posts[indexPath.row].Longitude)"
        let didLike = find(value: userID, in: Posts[indexPath.row].Likes)
        if didLike != nil {
            cell.btnLike.setImage(UIImage(named: "icons8-heart-fill"), for: .normal)
        }

        let didWantToGo = find(value: userID, in: Posts[indexPath.row].ThoseWhoWantToGo)
        if didWantToGo != nil {
            cell.btnTravel.setImage(UIImage(named: "icons8-airplane_take_off 2"), for: .normal)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 374
    }
}
