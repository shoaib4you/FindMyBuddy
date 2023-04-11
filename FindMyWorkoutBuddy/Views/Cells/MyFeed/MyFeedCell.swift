//
//  MyFeedCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class MyFeedCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDatetime: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var btnStackMoreButton: UIStackView!
    
    var cloLike:(()->Void)?
    var cloComment:(()->Void)?
    var cloMore:(()->Void)?
    var cloEdit:(()->Void)?
    var cloDelete:(()->Void)?
    
    var arr:[ResImages] = []
    var identifier = "ImageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clv.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.clv.dataSource = self
        self.clv.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        self.cloLike?()
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        self.cloComment?()
    }
    
    @IBAction func btnMore(_ sender: UIButton) {
        self.cloMore?()
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        self.cloEdit?()
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloDelete?()
    }
}

extension MyFeedCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        Utility.setImageWithSDWebImage(object.image ?? "", cell.img)
        cell.pageControl.numberOfPages = self.arr.count
        return cell
    }
}

extension MyFeedCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell as! ImageCell
        currentCell.pageControl.currentPage = indexPath.row
    }
}

extension MyFeedCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width, height: 200)
    }
}
