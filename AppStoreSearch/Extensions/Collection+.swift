//
//  Collection+.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
