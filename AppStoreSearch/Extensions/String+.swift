//
//  String+.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/19.
//

import Foundation

extension String {
    func numHangleChange() -> String {
        let text = self
        switch text.count {
        case 7:
            return "\(text[0])\(text[1])\(text[2])만"
        case 6:
            return "\(text[0])\(text[1])만"
        case 5:
            return "\(text[0]).\(text[1])만"
        case 4:
            return "\(text[0]).\(text[1])천"
        case 0...3:
            return self
        default:
            return self
        }
    }
    
    subscript(index: Int) -> Character {
        return self[String.Index(utf16Offset: index, in: self)]
    }
}

extension [String] {
    func namesWith(prefix: String) -> [String] {
        return self.filter { $0.prefix(prefix.count).caseInsensitiveCompare(prefix) == .orderedSame }
    }
}
