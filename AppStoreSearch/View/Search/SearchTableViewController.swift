//
//  SearchTableViewController.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import UIKit
import RxSwift
import RxCocoa

class SearchTableViewController: UITableViewController {
    private var searchController: UISearchController!
    private let humanButton = UIButton()
    public var searchedWordTableViewController = UIStoryboard(name: "SearchedWord", bundle: nil).instantiateViewController(withIdentifier: "SearchedWordTableViewController") as? SearchedWordTableViewController
    public let searchResultTableViewController = SearchResultTableViewController()
    private let networkMonitor = NetworkMonitor()
    private let networkView = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "NetworkNotConnectViewController")
    private let networkConnectSubject = PublishSubject<Bool>()
    private lazy var viewModel = SearchViewModel()
    private lazy var input = SearchViewModel.InputRx(
        searchedWordTableItem: BehaviorSubject<[String]>(value: []),
        searchTableItem: BehaviorSubject<[String]>(value: []),
        searchedWordTableListClick: self.searchedWordTableViewController!.tableView.rx.itemSelected,
        searchTableViewListClick: self.tableView.rx.itemSelected,
        searchBarWrite: self.searchController.searchBar.rx.text,
        cancelButtonClick: self.searchController.searchBar.rx.cancelButtonClicked,
        searchButtonClick: self.searchController.searchBar.rx.searchButtonClicked,
        networkConnectEvent: self.networkConnectSubject
    )
    private lazy var output = viewModel.transformInput(input: input)
    private var showViewController: UIViewController?
    private var disposeBag = DisposeBag()
    public var terms: [String] {
        let terms = TermSave.default.TermGet()
        input.searchedWordTableItem.onNext(terms)
        return terms
    }
    
    public var searchedTerm = String() {
        didSet {
            currentNames = terms.namesWith(prefix: searchedTerm)
        }
    }
    
    public var currentNames = [String]()
    
    deinit {
        networkMonitor.stopMonitoring()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        UserDefaults.standard.removeObject(forKey: "terms")
        setupLargeTitleAddButton(humanButton)
        setSearchController()
        bind()
    }
    
    private func bind() {
        output.searchedWordTableItem.bind(to: searchedWordTableViewController!.tableView.rx.items(cellIdentifier: "cell", cellType: SearchedWordTableViewCell.self)){ (row, element, cell) in
            cell.label.text = element
        }.disposed(by: disposeBag)
        
        output.searchedWordTableListClick.subscribe { [weak self] indexPath in
            guard let `self` = self else { return }
            guard let index = indexPath.element else { return }
            let term = self.currentNames[index.item]
            self.search(term: term)
            self.searchResultTableViewController.search(term: term)
            self.transition(self.searchResultTableViewController)
            self.searchedWordTableViewController?.remove()
            self.input.searchTableItem.onNext(self.terms)
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        output.searchTableItem.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        output.searchTableViewListClick.subscribe { [weak self] indexPath in
            guard let `self` = self else { return }
            guard let index = indexPath.element else { return }
            let term = self.terms[index.item]
            self.search(term: term)
            self.searchResultTableViewController.search(term: term)
            self.transition(self.searchResultTableViewController)
            self.searchedWordTableViewController?.remove()
            self.input.searchTableItem.onNext(self.terms)
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        output.searchBarWrite
            .filter {
                if $0 == "" {
                    self.showViewController?.remove()
                    self.tableView.isScrollEnabled = true
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                }
                return !$0!.isEmpty
            }
            .subscribe { [weak self] st in
                guard let `self` = self else { return }
                guard let str = st.element else { return }
                guard let text = str else { return }
                self.navigationController?.navigationBar.prefersLargeTitles = false
                self.searchedTerm = text
                self.input.searchedWordTableItem.onNext(self.currentNames)
                self.showViewController = self.searchedWordTableViewController
                self.transition(self.showViewController!)
                self.navigationController?.navigationBar.setShadow(hidden: text.isEmpty)
            }.disposed(by: disposeBag)
        
        output.cancelButtonClick.subscribe { [weak self] _ in
            guard let `self` = self else { return }
            self.showViewController?.remove()
            self.showViewController = nil
            self.tableView.isScrollEnabled = true
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.setShadow(hidden: true)
        }.disposed(by: disposeBag)
        
        output.searchButtonClick.subscribe { [weak self] _ in
            guard let `self` = self else { return }
            let term = self.searchedTerm
            self.search(term: term)
            self.searchResultTableViewController.search(term: term)
            self.transition(self.searchResultTableViewController)
            self.input.searchTableItem.onNext(self.terms)
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        networkMonitor.startMonitoring { [weak self] connectionStatus in
            guard let `self` = self else { return }
            switch connectionStatus {
            case .satisfied:
                // 네트워크 연결이 가능함
                self.networkConnectSubject.onNext(true)
            case .unsatisfied:
                // 네트워크 연결 경로가 없음 (wifi, lte 등이 꺼져있음)
                self.networkConnectSubject.onNext(false)
            default :
                self.networkConnectSubject.onNext(false)
            }
        }
        
        output.networkConnectEvent.subscribe { [weak self] connectBool in
            guard let `self` = self else { return }
            guard let connectBool = connectBool.element else { return }
            switch connectBool {
            case true:
                print("Network Connect Successful")
                self.networkView.view.removeFromSuperview()
            case false:
                print("Network Connect fail")
                self.parent?.view.addSubview(self.networkView.view)
            }
        }.disposed(by: disposeBag)
        
        input.searchTableItem.onNext(terms)
    }
    
    private func transition(_ viewController: UIViewController) {
        showViewController?.remove()
        let vc = viewController
        add(vc)
        showViewController = vc
    }
    
    private func setSearchController() {
        searchController = UISearchController(searchResultsController: searchedWordTableViewController)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.setShadow(hidden: true)
    }
    
    private func search(term: String) {
        searchController.searchBar.text = term
        searchController.isActive = true
        searchController.searchBar.resignFirstResponder()
        tableView.isScrollEnabled = false
        navigationController?.navigationBar.setShadow(hidden: false)
    }
    
}
