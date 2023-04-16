//
//  SearchDetailCollectionViewController.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit

class SearchDetailCollectionViewController: UICollectionViewController {
    public var searchData: SearchDataModel?
    private var cellHeight: CGFloat = 135
    private var configBool: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        collectionView!.register(UINib(nibName: "TitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "titleCell")
        collectionView!.register(UINib(nibName: "ImageCollectionView", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        collectionView!.register(UINib(nibName: "EvaluationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "evaluationCell")
        collectionView!.register(UINib(nibName: "SeeMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "seeMoreCell")
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        collectionView.decelerationRate = .fast
    }
}

extension SearchDetailCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return 1
            
        case 3:
            return 1
            
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch indexPath.section {
        case 0:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
            indexCell.config(searchData!)
            cell = indexCell
            
        case 1:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "evaluationCell", for: indexPath) as? EvaluationCollectionViewCell else { return UICollectionViewCell() }
            indexCell.config(searchData!)
            cell = indexCell
            
        case 2:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionView else { return UICollectionViewCell() }
            indexCell.config(searchData!)
            cell = indexCell
            
        case 3:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "seeMoreCell", for: indexPath) as? SeeMoreCollectionViewCell else { return UICollectionViewCell() }
            indexCell.config(searchData!, configBool)
            indexCell.sizeRefitAction = cellSizeRefit
            cell = indexCell
            
        default:
            break
        }
        return cell
    }
    
    private func cellSizeRefit(_ cellHeight: Double, _ configBool: Bool) {
        self.cellHeight = cellHeight
        self.configBool = configBool
        collectionView.performBatchUpdates {
            let indexPath = IndexPath(row: 0, section: 3)
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension SearchDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = view.bounds.width
        var height: CGFloat = 140
        
        switch indexPath.section {
        case 0 :
            width -= 40
        case 1 :
            height = 60
        case 2 :
            height = 425
        case 3 :
            width -= 40
            height = cellHeight
        default :
            break
        }
        
        return CGSize(width: width, height: height)
    }
}
