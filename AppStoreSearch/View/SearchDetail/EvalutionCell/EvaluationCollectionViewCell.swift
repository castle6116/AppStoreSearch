//
//  EvaluationCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/20.
//

import UIKit
import SnapKit

class EvaluationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var searchData: SearchDataModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpColltionView()
    }
    
    public func config(_ searchData: SearchDataModel) {
        self.searchData = searchData
        setUpColltionView()
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        collectionView.reloadData()
    }
    
    private func setUpColltionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EvaluationImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "starCell")
        collectionView.register(UINib(nibName: "EvalutionLabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labelCell")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView.decelerationRate = .fast
    }
}

extension EvaluationCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "starCell", for: indexPath) as? EvaluationImageCollectionViewCell else { return UICollectionViewCell() }
            indexCell.config(searchData!)
            cell = indexCell
        case 1:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? EvalutionLabelCollectionViewCell else { return UICollectionViewCell() }
            indexCell.configText(searchData?.trackContentRating ?? "", searchData?.genres.first ?? "", type: .trackContentRating)
            cell = indexCell
        case 2:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? EvalutionLabelCollectionViewCell else { return UICollectionViewCell() }
            indexCell.configText(searchData?.contentAdvisoryRating ?? "", "연령", type: .contentAdvisoryRating)
            cell = indexCell
        case 3:
            guard let indexCell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? EvalutionLabelCollectionViewCell else { return UICollectionViewCell() }
            indexCell.configText("개발자", searchData?.sellerName ?? "", type: .contentAdvisoryRating)
            cell = indexCell
        default :
            break
            
        }
        return cell
    }
    
}

extension EvaluationCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 120
        let height: CGFloat = 60
        
        switch indexPath.row {
        case 0:
            width = 200
        default:
            break
        }
        
        return CGSize(width: width, height: height)
        
    }
}
