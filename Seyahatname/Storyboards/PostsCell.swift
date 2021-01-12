//
//  PostsCell.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import Firebase
import MapKit
import UIKit

class PostsCell: UITableViewCell {
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var imgPlace: UIImageView!
    @IBOutlet var lblPostID: UILabel!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnTravel: UIButton!
    @IBOutlet var lblLatitude: UILabel!
    @IBOutlet var lblLongitude: UILabel!
    var vc: UIViewController?
    var imgDefaultLike: UIImage?
    var imgDefaultTravel: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        imgDefaultLike = btnLike.currentImage
        imgDefaultTravel = btnTravel.currentImage
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
                    if self.btnLike.currentImage == self.imgDefaultLike {
                        like = ["likes": likes + 1] as [String: Any]
                        self.btnLike.setImage(UIImage(named: "icons8-heart-fill"), for: .normal)
                    } else {
                        like = ["likes": likes - 1] as [String: Any]
                        self.btnLike.setImage(UIImage(named: "icons8-heart"), for: .normal)
                    }
                    post.setData(like, merge: true)

                } else {
                    print("Int Dönüşüm Problemi")
                }
            } else {
                print("Post Bulunmadı")
            }
        }
    }

    @IBAction func btnAddTravelBookClicked(_ sender: Any) {
        let db = Firestore.firestore()
        var coordinate: CLLocationCoordinate2D?
        coordinate?.latitude = Double(lblLatitude.text!)!
        coordinate?.longitude = Double(lblLongitude.text!)!

        let alert = UIAlertController(title: "Seyahat Adı", message: "Bu seyahati defterinize kaydetmek üzeresiniz lütfen seyahat adı giriniz.", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Seyahat Adı"
        }

        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: { [weak alert] _ in
            print("İptal")
        }))

        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { [weak alert] _ in
            let travel = ["name": alert?.textFields![0].text,
                          "latitude": self.lblLatitude.text!,
                          "longitude": self.lblLongitude.text!,
                          "by": Auth.auth().currentUser?.uid] as [String: Any]

            db.collection("TravelBook").addDocument(data: travel, completion: { error in
                if error != nil {
                    self.vc?.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"),
                                     animated: true,
                                     completion: nil)
                } else {
                    self.vc?.present(Notify.Alert(title: "Başarılı", message: "Seyahat Defterinize Eklendi."),
                                     animated: true,
                                     completion: nil)
                }
            })
        }))

        vc?.present(alert, animated: true, completion: nil)
    }
}
