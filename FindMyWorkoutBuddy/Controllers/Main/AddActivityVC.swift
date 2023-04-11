//
//  AddActivityVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 16/11/22.
//

import UIKit

class AddActivityVC: UIViewController {

    @IBOutlet weak var txtActivityName: UITextField!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnFromTime: UIButton!
    @IBOutlet weak var btnToTime: UIButton!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var lblMainHeading: UILabel!
    
    var selectedDate = ""
    var selectedFromTime = ""
    var selectedToTime = ""
    var image = UIImage()
    var cloSuccess:(()->Void)?
    
    var obj: ResJournalActivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindData()
    }
    
    func bindData() {
        if let object = obj {
            self.lblMainHeading.text = R.string.localizable.updateActivity()
            self.txtActivityName.text = object.activity_name ?? ""
            self.btnDate.setTitle(object.date ?? "", for: .normal)
            self.selectedDate = object.date ?? ""
            self.btnToTime.setTitle(object.to_time ?? "", for: .normal)
            self.selectedToTime = object.to_time ?? ""
            self.btnFromTime.setTitle(object.from_time ?? "", for: .normal)
            self.selectedFromTime = object.from_time ?? ""
            self.txtDescription.text = object.description ?? ""
            Utility.downloadImageBySDWebImage(object.image ?? "") { image, error in
                if let img = image {
                    self.btnImage.setImage(image, for: .normal)
                    self.image = img
                }
            }
        }
    }
    
    func paramSignup() -> [String:String] {
        var dict : [String:String] = [:]
        if let object = obj {
            dict["general_activity_id"] = object.id ?? ""
        }
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["cat_id"] = k.emptyString
        dict["cat_name"] = k.emptyString
        dict["activity_name"] = self.txtActivityName.text!
        dict["date"] = self.selectedDate
        dict["to_time"] = self.selectedToTime
        dict["from_time"] = self.selectedFromTime
        dict["description"] = self.txtDescription.text!
        return dict
    }
    
    func imageUpdateProfile() -> [String:UIImage] {
        var dict : [String:UIImage] = [:]
        dict["image"] = self.image
        return dict
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        print(self.paramSignup())
        if obj != nil {
            Api.shared.updateActivity(self, self.paramSignup(), images: self.imageUpdateProfile(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.activityUpdatedSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
                    self.cloSuccess?()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            Api.shared.addActivity(self, self.paramSignup(), images: self.imageUpdateProfile(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.activityAddedSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
                    self.cloSuccess?()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "MM/dd/yyyy", mode: .date) { dateString in
            self.selectedDate = dateString
            self.btnDate.setTitle(dateString, for: .normal)
            self.btnDate.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func btnFromTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "hh:mm a", mode: .time) { dateString in
            self.selectedFromTime = dateString
            self.btnFromTime.setTitle(dateString, for: .normal)
            self.btnFromTime.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func btnToTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "hh:mm a", mode: .time) { dateString in
            self.selectedToTime = dateString
            self.btnToTime.setTitle(dateString, for: .normal)
            self.btnToTime.setTitleColor(.black, for: .normal)
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
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
