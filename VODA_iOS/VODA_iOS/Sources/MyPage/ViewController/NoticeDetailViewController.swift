//
//  NoticeDetailViewController.swift
//  VODA_iOS
//
//  Created by 전소영 on 2021/09/13.
//

import UIKit

class NoticeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationUI()
    }
    
    private func setUpNavigationUI() {
        self.setBackButton(color: .black)
        self.setNavigationBarTransparency()
    }
}
