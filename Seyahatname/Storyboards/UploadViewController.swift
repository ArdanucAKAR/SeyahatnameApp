//
//  UploadViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Firebase
import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imgImage: UIImageView!
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var btnShare: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgImage.isUserInteractionEnabled = true
        let grImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imgImage.addGestureRecognizer(grImage)
    }

    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imgImage.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnShareClick(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")

        if let data = imgImage.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString

            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { _, error in
                if error != nil {
                    self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                } else {
                    imageReference.downloadURL { url, error in
                        if error != nil {
                            self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                        } else {
                            let imageUrl = url?.absoluteString
                            let postBy = Auth.auth().currentUser!.email!.components(separatedBy: "@")
                            // Database
                            let db = Firestore.firestore()
                            var dbReference: DocumentReference?
                            let post = ["imageUrl": imageUrl!,
                                        "postBy": postBy[0],
                                        "description": self.txtDescription.text!,
                                        "date": FieldValue.serverTimestamp(),
                                        "likes": 0] as [String: Any]

                            dbReference = db.collection("Posts").addDocument(data: post, completion: { error in
                                if error != nil {
                                    self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                                } else {
                                    self.imgImage.image = UIImage(named: "plus-sign")
                                    self.txtDescription.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
