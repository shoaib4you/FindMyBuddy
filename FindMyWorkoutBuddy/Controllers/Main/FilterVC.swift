//
//  FilterVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit
import MapKit

class FilterVC: UIViewController {

    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var txtRange: UITextField!
    
    var address = ""
    var lat = 0.0
    var lon = 0.0
    var location_cordinate:CLLocationCoordinate2D?
    var cloFilter:((_ lat: Double, _ lon: Double, _ radiusInMiles: String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: k.appName, CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (location_coordinate, lat, lon, address) in
            self.lat = lat
            self.lon = lon
            self.address = address
            self.location_cordinate = location_coordinate
            self.btnLocation.setTitle(address, for: .normal)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        self.cloFilter?(self.lat, self.lon, self.txtRange.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
