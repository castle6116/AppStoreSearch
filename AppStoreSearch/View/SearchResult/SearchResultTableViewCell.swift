//
//  SearchResultTableViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/19.
//

import UIKit
import Kingfisher
import Cosmos

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var starListView: CosmosView!
    @IBOutlet weak var screenshotStackView: UIStackView!
    @IBOutlet weak var getAppButton: UIButton!
    
    private var screenshotImageViews: [UIImageView] {
        return screenshotStackView.arrangedSubviews as! [UIImageView]
    }
    
    public func configure(searchData: SearchDataModel) {
        nameLabel.text = searchData.trackName
        genreLabel.text = searchData.genres.reduce("") { $0 + $1 + " " }
        likeNumLabel.text = String(searchData.userRatingCountForCurrentVersion).numHangleChange()
        getAppButton.layer.cornerRadius = 15
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = CGColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        iconImageView.kf.setImage(with: URL(string: searchData.artworkUrl512))
        for (index, screenshot) in searchData.screenshotUrls.enumerated() {
            screenshotImageViews[safe: index]?.kf.setImage(with: URL(string: screenshot))
            screenshotImageViews[safe: index]?.layer.borderWidth = 0.15
            screenshotImageViews[safe: index]?.layer.borderColor = UIColor.lightGray.cgColor
            screenshotImageViews[safe: index]?.layer.cornerRadius = 6
        }
        let average = round(searchData.averageUserRating * 10) / 10
        starListView.rating = average
    }
    
    public func cancel() {
        iconImageView.kf.cancelDownloadTask()
        screenshotImageViews.forEach { $0.kf.cancelDownloadTask() }
    }

}
