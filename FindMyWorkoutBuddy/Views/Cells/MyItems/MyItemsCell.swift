//
//  MyItemsCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class MyItemsCell: UITableViewCell {

    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDatetime: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var btnStackMoreButton: UIStackView!
    
    var arr:[ResImages] = []
    var identifier = "ImageCell"
    var cloMore:(()->Void)?
    var cloEdit:(()->Void)?
    var cloDelete:(()->Void)?
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

extension MyItemsCell: UICollectionViewDataSource {
    
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

extension MyItemsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell as! ImageCell
        currentCell.pageControl.currentPage = indexPath.row
    }
}

extension MyItemsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width, height: 200)
    }
}
