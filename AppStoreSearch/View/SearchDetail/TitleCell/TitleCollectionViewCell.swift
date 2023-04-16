//
//  TitleCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public func config(_ searchData: SearchDataModel) {
        iconImageView.kf.setImage(with: URL(string: (searchData.image[0])))
        iconImageView.layer.cornerRadius = 20
        titleLabel.text = searchData.trackName
        descriptionLabel.text = searchData.genres.reduce("") { $0 + $1 + " " }
        getButton.layer.cornerRadius = 12
    }
}
