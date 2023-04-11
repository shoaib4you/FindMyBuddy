//
//  FeedPostCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class FeedPostCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDatetime: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var btnReport: UIButton!
    
    var cloLike:(()->Void)?
    var cloComment:(()->Void)?
    var cloUserProfile:(()->Void)?
    var cloTappedOnImage:(()->Void)?
    var cloReport:(()->Void)?
    
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
    
    @IBAction func btnUserProfile(_ sender: UIButton) {
        self.cloUserProfile?()
    }
    
    @IBAction func btnReport(_ sender: UIButton) {
        self.cloReport?()
    }
}

extension FeedPostCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        Utility.setImageWithSDWebImage(object.image ?? "", cell.img)
        cell.pageControl.numberOfPages = self.arr.count
        cell.cloTapOnImage = {() in
            self.cloTappedOnImage?()
        }
        return cell
    }
}

extension FeedPostCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell as! ImageCell
        currentCell.pageControl.currentPage = indexPath.row
    }
}

extension FeedPostCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width, height: 200)
    }
}
