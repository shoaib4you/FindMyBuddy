//
//  EditProfileVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtAboutUs: UITextField!
    
    var image = UIImage()
    var cloSuccess:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
            if let image = response.image, image != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(response.image ?? "") { (image, error) in
                    if error == nil {
                        self.btnImage.setImage(image, for: .normal)
                    }
                }
            }
            self.txtFirstName.text = "\(response.first_name ?? "")"
            self.txtLastName.text = "\(response.last_name ?? "")"
            self.txtPhone.text = response.mobile ?? ""
            self.txtEmail.text = response.email ?? ""
            self.txtLocation.text = response.address ?? ""
            self.txtAboutUs.text = response.about_us ?? ""
        }
    }
    
    @IBAction func btnImage(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        self.updateProfile()
    }
    
    @IBAction func btnAddPhotos(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UploadPhotosVC") as! UploadPhotosVC
        self.present(vc, animated: true, completion: nil)
    }
    
    func updateProfile() {
        Api.shared.updateProfile(self, self.paramSignup(), images: self.imageUpdateProfile(), videos: [:]) { (response) in
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdateSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
                self.cloSuccess?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func paramSignup() -> [String:String] {
        var dict : [String:String] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["first_name"] = self.txtFirstName.text!
        dict["last_name"] = self.txtLastName.text!
        dict["email"] = self.txtEmail.text!
        dict["address"] = self.txtLocation.text!
        dict["lat"] = String(kAppDelegate.coordinate2.coordinate.latitude)
        dict["lon"] = String(kAppDelegate.coordinate2.coordinate.longitude)
        dict["mobile"] = self.txtPhone.text!
        dict["about_us"] = self.txtAboutUs.text!
        dict["register_id"] = k.emptyString
        dict["ios_register_id"] = k.iosRegisterId
        return dict
    }
    
    func imageUpdateProfile() -> [String:UIImage] {
        var dict : [String:UIImage] = [:]
        dict["image"] = self.image
        return dict
    }
}
