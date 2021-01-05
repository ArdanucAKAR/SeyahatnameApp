//
//  PostsCell.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import Firebase
import UIKit

class PostsCell: UITableViewCell {
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var imgPlace: UIImageView!
    @IBOutlet var lblPostID: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnLikeClicked(_ sender: Any) {
        let db = Firestore.firestore()
        var like: [String: Any] = [:]
        let post = db.collection("Posts").document(lblPostID.text!)
        post.getDocument { document, _ in
            if let document = document, document.exists {
                let postData = document.data()
                if let likes = postData?["likes"] as? Int {
                    like = ["likes": likes + 1] as [String: Any]
                    post.setData(like, merge: true)
                } else {
                    print("Int Dönüşüm Problemi")
                }
            } else {
                print("Post Bulunmadı")
            }
        }
    }

    @IBAction func btnAddTravelBookClicked(_ sender: Any) {}
}
