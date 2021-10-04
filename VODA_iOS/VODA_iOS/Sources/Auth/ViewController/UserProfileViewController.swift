//
//  UserProfileViewController.swift
//  VODA_iOS
//
//  Created by 전소영 on 2021/09/01.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userProfileEditImageView: UIImageView!
    @IBOutlet weak var userNickNameTextFieldView: UIView!
    @IBOutlet weak var userNickNameTextField: UITextField!
    @IBOutlet weak var completeButtonView: UIView!
    var pageCase: String?
    var completionHandler: ((UserProfileData) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackButton(color: .black)
        (rootViewController as? MainViewController)?.setTabBarHidden(true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.userProfileImageView.makeCircleView()
        self.userNickNameTextFieldView.makeCornerRadius(radius: 8)
        self.completeButtonView.makeCornerRadius(radius: 16)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addTapGesture() {
        userProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhoto)))
        userProfileEditImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhoto)))
    }
    
    @objc private func addPhoto() {
        showAddPhotoPopUp(completionHandler: { [weak self] image in
            self?.userProfileImageView.image = image
        })
    }
    
    @IBAction func completeUserInfoSetting(_ sender: UIButton) {
        if pageCase == "myPage" {
            if let profileUserImage = userProfileImageView.image {
                completionHandler?(UserProfileData(userNickName: "\(String(describing: userNickNameTextField.text))님", userProfileImage: profileUserImage, userProfileImageUrl: nil, userEmail: nil))
                navigationController?.popViewController(animated: false)
            }
        } else if pageCase == "Auth" {
            if let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                mainViewController.modalPresentationStyle = .fullScreen
                mainViewController.modalTransitionStyle = .crossDissolve
                self.present(mainViewController, animated: true)
            }
        }
    }
}
