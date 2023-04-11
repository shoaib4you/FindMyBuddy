//
//  PublicProductsCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class PublicProductsCell: UITableViewCell {

    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDatetime: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var btnReport: UIButton!
    
    var arr:[ResImages] = []
    var identifier = "ImageCell"
    var cloReport:(()->Void)?
    var cloTappedOnImage:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clv.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.clv.dataSource = self
        self.clv.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnReport(_ sender: UIButton) {
        self.cloReport?()
    }
}

extension PublicProductsCell: UICollectionViewDataSource {
    
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

extension PublicProductsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell as! ImageCell
        currentCell.pageControl.currentPage = indexPath.row
    }
}

extension PublicProductsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width, height: 200)
    }
}
