//
//  UploadViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Firebase
import MapKit
import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var imgImage: UIImageView!
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var btnShare: CustomButton!
    @IBOutlet var map: MKMapView!
    var locationManager = CLLocationManager()
    var imgDefault: UIImage?
    var choosenCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        imgImage.isUserInteractionEnabled = true
        let grImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imgImage.addGestureRecognizer(grImage)
        imgDefault = imgImage.image

        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let grMap = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(grMap:)))
        grMap.minimumPressDuration = 3
        map.addGestureRecognizer(grMap)
    }

    func removeAnnotation() {
        if let annotations = map?.annotations {
            map.removeAnnotations(annotations)
        }
    }

    @objc func chooseLocation(grMap: UILongPressGestureRecognizer) {
        if grMap.state == .began {
            let touchPoint = grMap.location(in: map)
            let touchCoordinate = map.convert(touchPoint, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinate
            choosenCoordinate = touchCoordinate
            map.addAnnotation(annotation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
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

        if imgImage.image != imgDefault, choosenCoordinate != nil {
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
                                // var dbReference: DocumentReference?
                                let post = ["imageUrl": imageUrl!,
                                            "postBy": postBy[0],
                                            "description": self.txtDescription.text!,
                                            "date": FieldValue.serverTimestamp(),
                                            "likes": [],
                                            "latitude": self.choosenCoordinate?.latitude,
                                            "longitude": self.choosenCoordinate?.longitude] as [String: Any]

                                /* dbReference = */ db.collection("Posts").addDocument(data: post, completion: { error in
                                    if error != nil {
                                        self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                                    } else {
                                        self.imgImage.image = UIImage(named: "plus-sign")
                                        self.txtDescription.text = ""
                                        self.removeAnnotation()
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                })
                            }
                        }
                    }
                }
            }
        } else {
            present(Notify.Alert(title: "Hata", message: "Lütfen fotoğraf yükleyin ve konum seçin."), animated: true, completion: nil)
        }
    }
}
