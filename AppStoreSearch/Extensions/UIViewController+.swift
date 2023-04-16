//
//  UIViewController+.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/19.
//

import UIKit
import SnapKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.centerIn(view: view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIView {
    func centerIn(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let layoutGuide = view.safeAreaLayoutGuide
        
        self.snp.makeConstraints {
            $0.edges.equalTo(layoutGuide.snp.edges)
        }
    }
}
