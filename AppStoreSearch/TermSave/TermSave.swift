//
//  TermSave.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import Foundation

final class TermSave {
    static let `default` = AppStoreSearch.TermSave()
    
    public func TermSave(_ item: String) {
        var terms = [String]()
        if let termList = UserDefaults.standard.object(forKey: "terms") as? [String] {
            terms = termList
        }
        if let index = terms.firstIndex(of: item) {
            terms.remove(at: index)
        }
        
        terms.append(item)
        UserDefaults.standard.setValue(terms, forKey: "terms")
    }
    
    public func TermGet() -> [String] {
        guard let terms = UserDefaults.standard.value(forKey: "terms") as? [String] else { return [] }
        return terms.reversed()
    }
}
