//
//  PrimaryMainVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class PrimaryMainVC: UIViewController {

    @IBOutlet weak var collectionViewOt: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    
    var currentIndex = 0
    var identifier = "PrimaryCell"
    
    var arrImg = [
        R.image.slide_1()
    ]
    
    var arrText = [
        R.string.localizable.findThePerfectWorkoutBuddy()
//        R.string.localizable.uploadYourDailyFeed(),
//        R.string.localizable.buyAndSellEquipment(),
//        R.string.localizable.subscription()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewOt.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        print(self.currentIndex)
        if self.currentIndex == 0 {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.currentIndex = self.currentIndex + 1
            self.pageControl.currentPage = self.currentIndex
            DispatchQueue.main.async {
                self.collectionViewOt.isPagingEnabled = false
                self.collectionViewOt.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true
                )
                self.collectionViewOt.isPagingEnabled = true
            }
        }
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PrimaryMainVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.primaryCell, for: indexPath)!
        cell.img.image = self.arrImg[indexPath.row]
     //   cell.lblHeading.text = self.arrText[indexPath.row]
//        cell.lblText.text = self.arrConText[indexPath.row]
        return cell
    }
}

extension PrimaryMainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
    }
}

extension PrimaryMainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        self.currentIndex = indexPath.row
        if indexPath.row == 1 {
            self.btnNext.setTitle(R.string.localizable.start(), for: .normal)
        } else {
            self.btnNext.setTitle(R.string.localizable.next(), for: .normal)
        }
    }
}
