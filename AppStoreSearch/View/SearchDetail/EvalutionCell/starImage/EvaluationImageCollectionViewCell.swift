//
//  EvaluationCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit
import Cosmos

class EvaluationImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var starListView: CosmosView!
    private var startStackImageViews: [UIImageView] {
        return starStackView.arrangedSubviews as! [UIImageView]
    }
    
    public func config(_ searchData: SearchDataModel) {
        let average = round(searchData.averageUserRating * 10) / 10
        gradeLabel.text = String(average)
        starListView.rating = average
        evaluationLabel.text = String(searchData.userRatingCountForCurrentVersion).numHangleChange() + "개의 평가"
    }
}
