//
//  BaseViewModel.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    associatedtype InputRx
    associatedtype OutputRx
    
    func transformInput(input: InputRx) -> OutputRx
}
