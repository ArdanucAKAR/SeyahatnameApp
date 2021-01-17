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

    func find(value searchValue: String, in array: [QueryDocumentSnapshot]) -> QueryDocumentSnapshot? {
        for (index, document) in array.enumerated() {
            if document.documentID == searchValue {
                return document
            }
        }
        return nil
    }

    @IBAction func btnLikeClicked(_ sender: Any) {
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid

        db.collection("Posts").whereField("likes", arrayContains: userID).getDocuments(completion: { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Bilinmeyen Hata")
            } else {
                if snapshot?.isEmpty != true, snapshot != nil {
                    let post: QueryDocumentSnapshot = self.find(value: self.lblPostID.text!, in: snapshot!.documents)!
                    if post != nil {
                        self.btnLike.setImage(UIImage(named: "icons8-heart"), for: .normal)
                        post.reference.updateData(["likes": FieldValue.arrayRemove([userID])])
                    }
                } else {
                    let post = db.collection("Posts").document(self.lblPostID.text!)
                    self.btnLike.setImage(UIImage(named: "icons8-heart-fill"), for: .normal)
                    post.updateData(["likes": FieldValue.arrayUnion([userID])])
                }
            }
        })
    }

    @IBAction func btnAddTravelBookClicked(_ sender: Any) {
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        var coordinate: CLLocationCoordinate2D?
        coordinate?.latitude = Double(lblLatitude.text!)!
        coordinate?.longitude = Double(lblLongitude.text!)!

        let alert = UIAlertController(title: "Seyahat Adı",
                                      message: "Bu seyahati defterinize kaydetmek üzeresiniz lütfen seyahat adı giriniz.",
                                      preferredStyle: .alert)

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
                          "by": userID,
                          "postID": self.lblPostID.text!] as [String: Any]

            db.collection("TravelBook").addDocument(data: travel, completion: { error in
                if error != nil {
                    self.vc?.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"),
                                     animated: true,
                                     completion: nil)
                } else {
                    self.vc?.present(Notify.Alert(title: "Başarılı", message: "Seyahat defterinize eklendi."),
                                     animated: true,
                                     completion: nil)
                }
            })

            db.collection("Posts")
                .document(self.lblPostID.text!)
                .updateData(["thoseWhoWantToGo": FieldValue.arrayUnion([userID])])

            self.btnTravel.setImage(UIImage(named: "icons8-airplane_take_off 2"), for: .normal)
        }))

        vc?.present(alert, animated: true, completion: nil)
    }
}
