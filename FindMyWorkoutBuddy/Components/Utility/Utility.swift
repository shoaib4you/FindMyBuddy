//
//  Utility.swift
//  Shipit
//
//  Created by mac on 24/09/18.
//  Copyright © 2018 Technorizen. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
import SafariServices

class Utility {
    
    typealias BlockerList = [[String: [String: String]]]
    
    class func isValidMobileNumber(_ mobileNo: String) -> Bool {
        let mobileNumberPattern: String = "^[0-9]{10}$"
        //@"^[7-9][0-9]{9}$";
        let mobileNumberPred = NSPredicate(format: "SELF MATCHES %@", mobileNumberPattern)
        let isValid: Bool = mobileNumberPred.evaluate(with: mobileNo)
        return isValid
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        let mobileNumberPattern: String = "^[0-9]{4}$"
        //@"^[7-9][0-9]{9}$";
        let mobileNumberPred = NSPredicate(format: "SELF MATCHES %@", mobileNumberPattern)
        let isValid: Bool = mobileNumberPred.evaluate(with: password)
        return isValid
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid: Bool = emailPred.evaluate(with: email)
        return isValid
    }
    
    class func isValidPinCode(_ pincode: String) -> Bool {
        let pinRegex: String = "^[0-9]{6}$"
        let pinTest = NSPredicate(format: "SELF MATCHES %@", pinRegex)
        let pinValidates: Bool = pinTest.evaluate(with: pincode)
        return pinValidates
    }
    
    class func convertDateFormat(withAMPM dateString: String, inputFormate: String, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormate
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = outputFormate
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getDateFrom(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        return date!
    }
    
    class func getDateString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "EEEE, MMM dd"
        let dateAMPM: String = dateFormatterAMPM.string(from: date!)
        return dateAMPM
    }
    
    class func getDateStringString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "hh:mm a"
        let dateAMPM: String = dateFormatterAMPM.string(from: date!)
        return dateAMPM
    }
    
    class func getDateTimeString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "dd-MMM-yyyy hh:mm a"
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getStringDateFromStringDate(withAMPM dateString: String, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = outputFormate
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale.current
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func getCurrentDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale.current
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func showAlertMessage(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: R.string.localizable.oK(), style: .default, handler: nil)
        //You can use a block here to handle a press on this button
        alertController.addAction(actionOk)
        parentVC.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertWithAction(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:  R.string.localizable.oK(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertYesNoAction(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.yes(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: R.string.localizable.no(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func logoutt() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "en")
        //        Switcher.logoutFromGuest()
    }
    
    class func showAlertRegistration(parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: k.appName, message: R.string.localizable.pleaseRegisterToContinue(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertWithCustomAction(withTitle title: String, message msg: String, firstTitle first: String, secondTitle second: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: first, style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: second, style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertYesNoActionCust(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Later", style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    //    isUserLogin
    class func isUserLogin ()-> Bool {
        if let login = k.userDefault.value(forKey: k.session.userLogin) as? Bool, login == true {
            return true
        }
        return false
    }
    
    class func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    class func checkNetworkConnectivityWithDisplayAlert( isShowAlert : Bool) -> Bool{
        let isNetworkAvaiable = InternetUtilClass.sharedInstance.hasConnectivity()
        return isNetworkAvaiable;
    }
    
    class func getStringFromDate(_ date: Date, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormate
        let newDate = dateFormatter.string(from: date) //pass Date here
        return newDate
    }
    
    class func encode(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    class func decode(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    class func addTapGesture(_ label: UILabel, _ vc: UIViewController, _ userId: String) {
//        self.labelTapped(_:)
        let labelTap = MyTapGesture(target: vc, action: #selector(self.labelTapped(_:)))
        labelTap.userId = userId
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    class func noDataFound(_ message: String, tableViewOt: UITableView, parentViewController parentVC: UIViewController) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableViewOt.bounds.size.width, height: tableViewOt.bounds.size.height))
        
        let center = (tableViewOt.bounds.size.width/2)
        let center_y = (tableViewOt.bounds.size.height/2)
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "search (1)"))
        imageView.frame = CGRect(x: center - 50, y: center_y - 150, width: 100, height: 100)
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: center_y - 25, width: tableViewOt.bounds.size.width, height: 20))
        label.font = label.font.withSize(17.0)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.text = message
        //        label.textColor = parentVC.hexStringToUIColor(hex: "#5A5C63")
        label.textColor = UIColor(red: CGFloat(90)/255, green: CGFloat(92)/255, blue: CGFloat(99)/255, alpha :1)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        
        let label2: UILabel = UILabel(frame: CGRect(x: 0, y: center_y, width: tableViewOt.bounds.size.width, height: 20))
        label2.font = label.font.withSize(13.0)
        label2.text = R.string.localizable.noDataAvailableToShow()
        //        label2.textColor = UIColor(red: CGFloat(150)/255, green: CGFloat(150)/255, blue: CGFloat(150)/255, alpha :1)
        label2.textColor = parentVC.hexStringToUIColor(hex: "#95979B")
        label2.textAlignment = NSTextAlignment.center
        label2.numberOfLines = 0
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(label2)
        tableViewOt.backgroundView = view
    }
    
    // For text view
    class func autoresizeTextView(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        textView.font = font
        textView.text = text
        textView.sizeToFit()
        if let textNSString: NSString = textView.text as NSString? {
            let rect = textNSString.boundingRect(with: CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: textView.font!],
                                                 context: nil)
            textView.frame = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.size.width, height: rect.height)
        }
        return textView.frame.height
    }
    
    class func setImageWithSDWebImage(_ url: String, _ imageView: UIImageView) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        imageView.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
    }
    
    class func downloadImageBySDWebImage(_ url: String, successBlock success : @escaping ( _ image : UIImage?, _  error: Error?) -> Void) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: urlLogo, options: .continueInBackground, progress: nil, completed: { (image, data, error, boool) in
            success(image, error)
        })
    }
    
    class func blockUi() {
        let spinnerActivity = MBProgressHUD.showAdded(to: UIApplication.topViewController()!.view, animated: true);
        if spinnerActivity.isUserInteractionEnabled {
            spinnerActivity.bezelView.isHidden = true
            spinnerActivity.bezelView.color = .clear
            spinnerActivity.isUserInteractionEnabled = true;
        }
    }
    
    class func unBlockUi() {
        MBProgressHUD.hide(for: UIApplication.topViewController()!.view, animated: true)
    }
    
    class func setCurrentLocation(_ mapView: MKMapView) {
        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.setRegion(region, animated: true)
    }
    
    /******************************************************************************************/
    //MARK:-  Mapkit
    /******************************************************************************************/
    
    class func initMapViewAnnotation(_ mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        mapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                mapView.removeAnnotation($0)
            }
        }
    }
    
    class func showCurrentLocation(_ mapView: MKMapView, _ vc: UIViewController) {
        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
    }
    
    class func getLocationByCoordinates (location: CLLocation, successBlock success: @escaping (_ address: String, _ display_address: String) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            var address_display = ""
            if let city = addressDict["City"] as? String {
                if let zip = addressDict["ZIP"] as? String {
                    address_display = city + " " + zip
                }
            }
            
            // Print fully formatted address
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                let address = (formattedAddress.joined(separator: ", "))
                success(address, address_display)
            }
        })
    }
    
    class func getCurrentAddress( successBlock success: @escaping (_ address: String) -> Void) {
        Utility.lookUpCurrentLocation { (Placemark) in
            guard let addressDict = Placemark?.addressDictionary else {
                return
            }
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                let address = (formattedAddress.joined(separator: ", "))
                success(address)
            }
        }
    }
    
    class func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                                     -> Void ) {
        // Use the last reported location.
        if let lastLocation = LocationManager.sharedInstance.lastLocation {
            let geocoder = CLGeocoder()
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        } else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    class func showRouteOnMap(_ mapView: MKMapView, _ pickupCoordinate: CLLocationCoordinate2D, _ destinationCoordinate: CLLocationCoordinate2D, _ vc: UIViewController,top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        
        Utility.initMapViewAnnotation(mapView)
        
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = CustomPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
            sourceAnnotation.imageName = "dot_purple.png"
            sourceAnnotation.point = "source"
        }
        
        let destinationAnnotation = CustomPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
            destinationAnnotation.imageName = "dot_blue.png"
            destinationAnnotation.point = "destination"
        }
        
        mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            //            let rect = route.polyline.boundingMapRect
            //            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            
            let mapRect = MKPolygon(points: route.polyline.points(), count: route.polyline.pointCount)
            mapView.setVisibleMapRect(mapRect.boundingMapRect, edgePadding: UIEdgeInsets(top: top,left: left,bottom: bottom,right: right), animated: true)
        }
    }
}

class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
}

class MyTapGesture: UITapGestureRecognizer {
    var userId = String()
}
