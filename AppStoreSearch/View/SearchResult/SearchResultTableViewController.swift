//
//  SearchResultTableViewController.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/19.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SearchResultTableViewController: UITableViewController {
    private lazy var viewModel = SearchResultViewModel()
    public lazy var input = SearchResultViewModel.InputRx(
        searchData: PublishSubject<[SearchDataModel]>(),
        tableViewSeleted: self.tableView.rx.itemSelected,
        cellEndDisplay: self.tableView.rx.didEndDisplayingCell)
    private lazy var output = self.viewModel.transformInput(input: input)
    private var disposeBag = DisposeBag()
    private var searchDatas = [SearchDataModel]()
    private var imagePrefetcher: ImagePrefetcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        bind()
    }
    
    private func bind() {
        output.searchData.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SearchResultTableViewCell.self)) { (row, element, cell) in
            cell.configure(searchData: element)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        output.tableViewSeleted.subscribe { [weak self] indexPath in
            guard let `self` = self else { return }
            guard let index = indexPath.element else { return }
            guard let vc = UIStoryboard(name: "SearchDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchDetailCollectionViewController") as? SearchDetailCollectionViewController else { return }
            vc.searchData = self.searchDatas[index.item]
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }.disposed(by: disposeBag)
        
        output.cellEndDisplay.subscribe { event in
            guard let cell = event.0 as? SearchResultTableViewCell else { return }
            cell.cancel()
        }.disposed(by: disposeBag)
    }

    public func search(term: String) {
        TermSave.default.TermSave(term)
        Network.default.AppstoreSearch("https://itunes.apple.com/search?term=\(term)&country=kr&entity=software&limit=10") { [weak self] searchData, statusCode, error  in
            guard let `self` = self else { return }
            if let searchData = searchData {
                self.tableView.contentOffset = CGPoint(x: 0, y: 0)
//                self.searchData = searchData.results
                self.input.searchData.onNext(searchData.results)
                self.searchDatas = searchData.results
                let cacheImage = self.searchDatas.flatMap { $0.image }.compactMap { URL(string:$0) }
                self.imagePrefetcher = ImagePrefetcher(urls: cacheImage)
                self.imagePrefetcher?.start()
                self.tableView.reloadData()
            }
        }
    }
}
