//
//  SuggestedTermTableViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import UIKit

class SearchedWordTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!

    public func set(term: String, searchedTerm: String) {
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = term.lowercased()
    }
}
