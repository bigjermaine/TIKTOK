//
//  ProfileViewController.swift
//  TIKTOK
//
//  Created by Apple on 15/05/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var user:User
    init(user:User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = user.username
    }
   

}
