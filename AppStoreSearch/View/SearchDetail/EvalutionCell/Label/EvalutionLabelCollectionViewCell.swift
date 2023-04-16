//
//  EvalutionLabelCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

class EvalutionLabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    public func configText(_ gradeString: String, _ contentString: String, type: EvalutionType) {
        var gradeText = ""
        if type == .trackContentRating {
            gradeText = "#" + gradeString.map {
                if Int(String($0)) != nil {
                    return String($0)
                } else {
                    return String()
                }
            }.reduce("") { $0 + $1 }
        } else if type == .contentAdvisoryRating {
            gradeText = gradeString
        }
        gradeLabel.text = gradeText
        contentLabel.text = contentString
    }
}
