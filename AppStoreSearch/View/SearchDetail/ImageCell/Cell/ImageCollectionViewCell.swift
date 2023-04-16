//
//  ImageCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func config(_ imageURL: String) {
        imageView.kf.setImage(with: URL(string: imageURL))
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
}
