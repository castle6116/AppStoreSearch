//
//  SeeMoreCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

class SeeMoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var developerNameLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var moreTextView: UITextView!
    @IBOutlet weak var moreTextButton: UIButton!
    @IBAction func moreTextButtonAction(_ sender: Any) {
        moreTextView.text = searchData?.description
        moreTextView.translatesAutoresizingMaskIntoConstraints = true
        moreTextView.isScrollEnabled = false
        moreTextView.sizeToFit()
        let size = moreTextView.frame.height + 60
        sizeRefitAction(size, true)
    }
    private var searchData: SearchDataModel?
    public var sizeRefitAction: (Double, Bool) -> Void = { _,_  in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func config(_ searchData: SearchDataModel, _ configBool: Bool) {
        self.searchData = searchData
        developerNameLabel.text = searchData.sellerName
        if configBool == false {
            let text = searchData.description.enumerated()
                .filter {
                    $0.offset < 80
                }.map {
                    String($0.element)
                }.reduce("", +)
            moreTextView.text = text
            moreTextView.isScrollEnabled = false
            moreTextButton.layer.shadowColor = UIColor.white.cgColor
            moreTextButton.layer.masksToBounds = false
            moreTextButton.layer.shadowOffset = .zero
            moreTextButton.layer.shadowRadius = 5
            moreTextButton.layer.shadowOpacity = 0.4
        } else {
            moreTextView.text = searchData.description
            moreTextView.isScrollEnabled = false
            moreTextButton.isHidden = true
        }
    }
    
}
