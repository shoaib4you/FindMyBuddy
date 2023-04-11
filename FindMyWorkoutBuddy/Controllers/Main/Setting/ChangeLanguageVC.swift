//
//  ChangeLanguageVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 24/10/22.
//

import UIKit

class ChangeLanguageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.changeLanguage(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }

    @IBAction func btnEnglish(_ sender: UIButton) {
        k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "en")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnFrench(_ sender: UIButton) {
        k.userDefault.set(emLang.french.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "fr")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnSpanish(_ sender: UIButton) {
        k.userDefault.set(emLang.spanish.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "es")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnRussain(_ sender: UIButton) {
        k.userDefault.set(emLang.russian.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "ru")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnGerman(_ sender: UIButton) {
        k.userDefault.set(emLang.german.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "de")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnKorean(_ sender: UIButton) {
        k.userDefault.set(emLang.korean.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "ko")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnItalian(_ sender: UIButton) {
        k.userDefault.set(emLang.italian.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "it")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnPortuguese(_ sender: UIButton) {
        k.userDefault.set(emLang.portugese.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "pt-PT")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnChinese(_ sender: UIButton) {
        k.userDefault.set(emLang.chinese.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "zh-Hant")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnJapanese(_ sender: UIButton) {
        k.userDefault.set(emLang.japanese.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "ja")
        Switcher.updateRootVC()
    }
}
