//
//  NavigationLargeTitleImage.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import UIKit
import SnapKit

extension UITableViewController {
    func setupLargeTitleAddButton(_ button: UIButton) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        button.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        navigationBar.addSubview(view)
        guard let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else { return }
        self.navigationController?.navigationBar.subviews.forEach { subview in
            if subview.isKind(of: (UINavigationBarLargeTitleView.self)) {
                let controller = view
                controller.translatesAutoresizingMaskIntoConstraints = false
                subview.addSubview(controller)
                controller.snp.makeConstraints {
                    $0.bottom.equalTo(subview.snp.bottom).offset(-15)
                    $0.right.equalTo(subview.snp.right).offset(-subview.directionalLayoutMargins.trailing)
                }
            }
        }
    }
}
