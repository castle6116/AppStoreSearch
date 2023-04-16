//
//  SearchViewModel.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    struct InputRx {
        /// searchedWordTable Cell Item
        var searchedWordTableItem: BehaviorSubject<[String]>
        /// searchTableItem Cell Item
        var searchTableItem: BehaviorSubject<[String]>
        /// searchedWordTable  리스트 클릭 시 작동
        var searchedWordTableListClick: ControlEvent<IndexPath>
        /// searchTableViewListClick 리스트 클릭 시 작동
        var searchTableViewListClick: ControlEvent<IndexPath>
        /// searchBar 문자열 입력 시 작동
        var searchBarWrite: ControlProperty<String?>
        /// searchBar cancel 버튼 클릭 시 작동
        var cancelButtonClick: ControlEvent<Void>
        /// searchBar 검색하기 클릭 시 작동
        var searchButtonClick: ControlEvent<Void>
        /// Network 연결 혹은 끊김이 발생했을 때 작동하는 이벤트
        var networkConnectEvent: PublishSubject<Bool>
    }
    
    struct OutputRx {
        /// searchedWordTable Cell Item
        var searchedWordTableItem: BehaviorSubject<[String]>
        /// searchTableItem Cell Item
        var searchTableItem: BehaviorSubject<[String]>
        /// searchedWordTable  리스트 클릭 시 작동
        var searchedWordTableListClick: ControlEvent<IndexPath>
        /// searchTableViewListClick 리스트 클릭 시 작동
        var searchTableViewListClick: ControlEvent<IndexPath>
        /// searchBar 문자열 입력 시 작동
        var searchBarWrite: ControlProperty<String?>
        /// searchBar cancel 버튼 클릭 시 작동
        var cancelButtonClick: ControlEvent<Void>
        /// searchBar 검색하기 클릭 시 작동
        var searchButtonClick: ControlEvent<Void>
        /// Network 연결 혹은 끊김이 발생했을 때 작동하는 이벤트
        var networkConnectEvent: PublishSubject<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
}

extension SearchViewModel {
    public func transformInput(input: InputRx) -> OutputRx {
        let searchedWordTableItem = input.searchedWordTableItem
        let searchTableItem = input.searchTableItem
        let searchedWordTableListClick = input.searchedWordTableListClick
        let searchTableViewListClick = input.searchTableViewListClick
        let searchBarWrite = input.searchBarWrite
        let cancelClick = input.cancelButtonClick
        let searchButtonClick = input.searchButtonClick
        let networkConnectEvent = input.networkConnectEvent
        return OutputRx(
            searchedWordTableItem: searchedWordTableItem,
            searchTableItem: searchTableItem,
            searchedWordTableListClick: searchedWordTableListClick,
            searchTableViewListClick: searchTableViewListClick,
            searchBarWrite: searchBarWrite,
            cancelButtonClick: cancelClick,
            searchButtonClick: searchButtonClick,
            networkConnectEvent: networkConnectEvent)
    }
}
