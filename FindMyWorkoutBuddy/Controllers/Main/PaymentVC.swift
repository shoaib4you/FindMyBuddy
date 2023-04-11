//
//  PaymentVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 28/10/22.
//

import UIKit
import InputMask
import Stripe
import SwiftyJSON

class PaymentVC: UIViewController {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpDate: UITextField!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var txtZipPostalCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listnerCardExpDate: MaskedTextFieldDelegate!
    
    var amount = 0.0
    var planId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblAmount.text = "\(R.string.localizable.total()) \(k.currency) \(self.amount)"
        self.configureListener()
    }
    
    func configureListener() {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listnerCardExpDate.affinityCalculationStrategy = .prefix
        listnerCardExpDate.affineFormats = ["[00]/[00]"]
    }
    
    func cardValidation() {
        let cardParams = STPCardParams()
        
        // Split the expiration date to extract Month & Year
        if self.txtCardHolderName.text?.isEmpty == false && self.txtCvv.text?.isEmpty == false && self.txtExpDate.text?.isEmpty == false && self.txtExpDate.text?.isEmpty == false {
            let expirationDate = self.txtExpDate.text?.components(separatedBy: "/")
            let expMonth = UInt((expirationDate?[0])!)
            let expYear = UInt((expirationDate?[1])!)
            
            // Send the card info to Strip to get the token
            cardParams.number = self.txtCardNumber.text
            cardParams.cvc = self.txtCvv.text
            cardParams.expMonth = expMonth!
            cardParams.expYear = expYear!
            
            //            let cardBrand = STPCardValidator.brand(forNumber: self.txtCardNumber.text!)
            //            let cardImage = STPImageLibrary.brandImage(for: cardBrand)
            //            self.imgWallet.image = cardImage
        }
        
        let cardState = STPCardValidator.validationState(forCard: cardParams)
        switch cardState {
        case .valid:
            self.generateToken(cardParams)
        case .invalid:
            self.alert(alertmessage: R.string.localizable.cardInInvalid())
        case .incomplete:
            self.alert(alertmessage: R.string.localizable.cardIsIncomplete())
        default:
            print("default")
        }
    }
    
    func generateToken(_ cardParams: STPCardParams) {
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.somethingWentWrong(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    
                })
                return
            }
            print(token.tokenId)
            self.stripePayment(token.tokenId)
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.cardValidation()
    }
    
    func stripePayment(_ token: String) {
        Api.shared.stripePayment(self, self.paramStripePayment(token)) { responseData in
            self.parseDataSaveCard(apiResponse: responseData)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject) {
        DispatchQueue.main.async {
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                self.addPayment(swiftyJsonVar["result"]["id"].stringValue)
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.somethingWentWrong(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    
                })
            }
            self.unBlockUi()
        }
    }
    
    func paramStripePayment(_ token: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["total_amount"] = self.amount as AnyObject
        dict["payment_method"] = "Card" as AnyObject
        dict["token"] = token as AnyObject
        dict["currency"] = "USD" as AnyObject
        return dict
    }
    
    func paramAddPayment(_ transactionId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["amount"] = self.amount as AnyObject
        dict["transaction_id"] = transactionId as AnyObject
        dict["plan_id"] = self.planId as AnyObject
        return dict
    }
    
    func addPayment(_ transactionId: String) {
        print(self.paramAddPayment(transactionId))
        Api.shared.addPayment(self, self.paramAddPayment(transactionId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.transactionIsSuccessfull(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                self.dismiss(animated: true) {
                    Switcher.updateRootVC()
                }
            })
        }
    }
}
