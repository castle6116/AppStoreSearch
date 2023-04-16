//
//  SearchResultViewModel.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/22.
//
import Foundation
import RxSwift
import RxCocoa

class SearchResultViewModel: BaseViewModel {
    public func transformInput(input: InputRx) -> OutputRx {
        let searchData = input.searchData
        let tableViewSeleted = input.tableViewSeleted
        let cellEndDisplay = input.cellEndDisplay
        
        return OutputRx(
            searchData: searchData,
            tableViewSeleted: tableViewSeleted,
            cellEndDisplay: cellEndDisplay
        )
    }
    
    struct InputRx {
        /// 검색 데이터
        var searchData: PublishSubject<[SearchDataModel]>
        /// 테이블 선택 이벤트
        var tableViewSeleted: ControlEvent<IndexPath>
        /// 셀이 보이지 않을 때 나타나는 이벤트
        var cellEndDisplay: ControlEvent<DidEndDisplayingCellEvent>
    }
    
    struct OutputRx {
        /// 검색 데이터
        var searchData: PublishSubject<[SearchDataModel]>
        /// 테이블 선택 이벤트
        var tableViewSeleted: ControlEvent<IndexPath>
        /// 셀이 보이지 않을 때 나타나는 이벤트
        var cellEndDisplay: ControlEvent<DidEndDisplayingCellEvent>
    }
    
    var disposeBag = DisposeBag()
    
    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
}
