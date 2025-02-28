//
//  PushViewController.swift
//  VODA_iOS
//
//  Created by 전소영 on 2021/07/30.
//

import UIKit

class PushViewController: UIViewController {
    @IBOutlet weak var pushView: UIView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarColor(color: .clear)
        pushView.addShadow(width: 0, height: -4, radius: 8, opacity: 0.1)
        currentDateLabel.text = getCurrentDate()
    }
    
    private func getCurrentDate() -> String {
        let nowDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let currentDate = dateFormatter.string(from: nowDate)
        
        return currentDate
    }
}

// MARK: UICollectionViewDataSource
extension PushViewController: UICollectionViewDataSource {
    //FIXME: 현재 테스트만 완료, 서버 연동 필요
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PushCollectionViewCell", for: indexPath)
        
        let pushCollectionViewCell = cell as? PushCollectionViewCell
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PushViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int(DeviceInfo.screenWidth), height: 87)
    }
}
