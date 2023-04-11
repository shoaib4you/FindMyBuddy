//
//  FindBuddyMapVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit
import MapKit
import SDWebImage
import Gallery

class FindBuddyMapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var arr:[ResNearestUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        LocationManager.sharedInstance.delegate = kAppDelegate
        LocationManager.sharedInstance.startUpdatingLocation()
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        self.getNearestUser(lat,lon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getNearestUser(_ lat: Double, _ lon: Double) {
        print(self.paramGetNearestUser(lat, lon))
        Api.shared.getNearestUser(self, self.paramGetNearestUser(lat, lon)) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.showAnnotationNearestDrivers(responseData)
        }
    }
    
    func paramGetNearestUser(_ lat: Double, _ lon: Double) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["lat"] = lat as AnyObject
        dict["lon"] = lon as AnyObject
        return dict
    }
    
    func showAnnotationNearestDrivers(_ arrDrivers: [ResNearestUser]) {
        if arrDrivers.count > 0 {
            for (i, val) in arrDrivers.enumerated() {
                print(val.first_name)
                print(val.lat)
                print(val.lon)
                let lat = Double(val.lat ?? "0") ?? 0.0
                let lon = Double(val.lon ?? "0") ?? 0.0
                let coordinate = CLLocationCoordinate2DMake(lat, lon)
                let objAnnotation = MapAnnotation(coordinate: coordinate)
                objAnnotation.title = "\(val.first_name ?? "") \(val.last_name ?? "")"
                objAnnotation.subtitle = ""
                objAnnotation.isDriver = true
                objAnnotation.tagg = i
                objAnnotation.imageName = val.image ?? ""
                self.mapView.addAnnotation(objAnnotation)
                //                self.arrMapAnnotation.append(objAnnotation)
            }
        }
        
        self.mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan.init(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        let coordinate = CLLocationCoordinate2DMake(lat, lon)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.cloFilter = {(lat,lon,range) in
            self.getNearestUser(lat, lon)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func createSettingsAlertController(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString(R.string.localizable.cancel(), comment: ""), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString(R.string.localizable.settings(), comment: ""), style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension FindBuddyMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        //        if !(annotation is CustomPointAnnotation) {
        //            return nil
        //        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        } else {
            anView!.annotation = annotation
        }
        
        
        
        let deleteButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        deleteButton.frame.size.width = 44
        deleteButton.frame.size.height = 44
        deleteButton.backgroundColor = .lightGray
        deleteButton.setImage(UIImage(named: "next"), for: .normal)
        
        anView?.rightCalloutAccessoryView = deleteButton
        
        if annotation is MapAnnotation {
            let cpa = annotation as! MapAnnotation
            if let img = cpa.imageName, img != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(cpa.imageName) { (image, error) in
                    // Resize image
                    let size = CGSize(width: 32, height: 32)
                    UIGraphicsBeginImageContext(size)
                    image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    if let img = resizedImage {
                        anView?.image = self.maskRoundedImage(image: img, radius: 16)
                    }
                }
            } else {
                let image = UIImage.init(named: "placeholder")
                let size = CGSize(width: 32, height: 32)
                UIGraphicsBeginImageContext(size)
                image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                if let img = resizedImage {
                    anView?.image = self.maskRoundedImage(image: img, radius: 16)
                }
            }
        }
        //        anView?.image = UIImage.init(named: "contractmarker")
        return anView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //        if let overlay = overlay as? MKPolyline {
        /// define a list of colors you want in your gradient
        let gradientColors = [ hexStringToUIColor(hex: "#8728E2"), hexStringToUIColor(hex: "#3B67F7")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
        //        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
        if let atmPin = view.annotation as? MapAnnotation {
            vc.friendId = self.arr[atmPin.tagg].id ?? ""
        }
        //        vc.modalTransitionStyle = .crossDissolve
        //        vc.modalPresentationStyle = .overCurrentContext
        //        vc.cloSeeDetail = {() in
        //            let vcc = R.storyboard.main().instantiateViewController(withIdentifier: "EmpOrderDetailVC") as! EmpOrderDetailVC
        //            if let atmPin = view.annotation as? MapAnnotation {
        //                vcc.contractId = self.arr[atmPin.tagg].id ?? ""
        //            }
        //            vcc.modalTransitionStyle = .crossDissolve
        //            vcc.modalPresentationStyle = .overCurrentContext
        ////            self.present(vcc, animated: true, completion: nil)
        //            self.navigationController?.pushViewController(vcc, animated: true)
        //        }
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.present(vc, animated: true, completion: nil)
    }
    
    func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("didFailToLocateUserWithError called")
//        self.createSettingsAlertController(title: k.appName, message: "Please give access to location in order to have best services.")
//        Utility.showAlertWithAction(withTitle: k.appName, message: "You did not give access to location, so data based on location may be incorrect.", delegate: nil, parentViewController: self) { boool in
//
//        }
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("withError called")
        Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.somethingWentWrongWithMap(), delegate: nil, parentViewController: self)
    }
}
