//
//  CollectionViewCell.swift
//  DisplayImages
//
//  Created by Developer on 16/02/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        imageView.layer.cornerRadius = 10
    }
}
