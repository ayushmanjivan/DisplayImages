//
//  TableViewCell.swift
//  DisplayImages
//
//  Created by Developer on 16/02/24.
//

import UIKit

class TableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
