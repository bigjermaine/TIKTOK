//
//  TabBarViewController.swift
//  TIKTOK
//
//  Created by Apple on 15/05/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let Vc1 = HomeViewController()
        let Vc2 = ExploreViewController()
        let camera = CameraViewController()
        let Vc4 =  NotificationViewController()
        let Vc5 = ProfileViewController(user: User(username: "self", profilePictureURL: nil, identifier: "12345"))
          
        let nav1 = UINavigationController(rootViewController: Vc1)
        let nav2 = UINavigationController(rootViewController: Vc2)
        let nav4 = UINavigationController(rootViewController: Vc4)
        let nav5 = UINavigationController(rootViewController: Vc4)
        let cameraNav  = UINavigationController(rootViewController: camera)
       
       
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label
        nav5.navigationBar.tintColor = .label
      
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName:"magnifyingglass"), tag: 5)
         nav4.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell"), tag: 3)
        nav5.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 4)
        cameraNav.tabBarItem = UITabBarItem(title: "camera", image: UIImage(systemName: "Camera"), tag: 2)
      
        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()
        
        
        
        cameraNav.navigationBar.backgroundColor = .clear
        cameraNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        cameraNav.navigationBar.shadowImage = UIImage()
        
           
        setViewControllers([nav1,nav2,cameraNav,nav4,nav5], animated: false)
      
      
    }
    


}
