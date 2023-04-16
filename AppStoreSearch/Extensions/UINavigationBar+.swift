//
//  UINavigationBar+.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

extension UINavigationBar {
    func setShadow(hidden: Bool) {
        var color: UIColor
        if !hidden {
            color = .clear
        } else {
            color = .white
        }
        
        scrollEdgeAppearance?.backgroundColor = color
        setValue(hidden, forKey: "hidesShadow")
    }
}
