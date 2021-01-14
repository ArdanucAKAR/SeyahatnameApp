//
//  TravelBookViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 14.01.2021.
//

import Firebase
import MapKit
import UIKit

class TravelBookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var TravelBook = [Travel]()
    @IBOutlet var tblTravelBook: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblTravelBook.delegate = self
        tblTravelBook.dataSource = self
        GetTravelBook()
    }

    func GetTravelBook() {
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid

        db.collection("TravelBook").whereField("by", isEqualTo: id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Bilinmeyen Hata")
            } else {
                if snapshot?.isEmpty != true, snapshot != nil {
                    self.TravelBook.removeAll()
                    for document in snapshot!.documents {
                        let data = document.data()
                        let travel = Travel(id: document.documentID,
                                            name: data["name"] as! String,
                                            coordinate: CLLocationCoordinate2D(latitude: Double((data["latitude"] as! NSString).doubleValue), longitude: Double((data["longitude"] as! NSString).doubleValue)),
                                            by: data["by"] as! String)
                        self.TravelBook.append(travel)
                    }

                    self.tblTravelBook.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelBook.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = TravelBook[indexPath.row].Name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = CLLocation(latitude: TravelBook[indexPath.row].Coordinate.latitude,
                                  longitude: TravelBook[indexPath.row].Coordinate.longitude)

        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, _ in
            if let placemark = placeMarks {
                if placemark.count > 0 {
                    let newPlaceMark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlaceMark)
                    item.name = self.TravelBook[indexPath.row].Name
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }
            }
        }
    }
}
