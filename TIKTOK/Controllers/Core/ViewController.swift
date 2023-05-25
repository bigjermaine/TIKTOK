//
//  ViewController.swift
//  TIKTOK
//
//  Created by Apple on 15/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    private var foryouposts  = PostModel.mockmodels()
    private var followingposts  = PostModel.mockmodels()
    
     let horizontalScrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView

    }()
    
     let control:UISegmentedControl = {
        let titles = ["Following","For You"]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        
       return control
    }()
    private  var forpagingController =
    UIPageViewController(transitionStyle:
            .scroll, navigationOrientation:
            .vertical,options: [:])
    
      
    private  let folowwingpagingController =
    UIPageViewController(transitionStyle:
            .scroll, navigationOrientation:
            .vertical,options: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setUpFeed()
        horizontalScrollView.contentInsetAdjustmentBehavior = .never
        control.addTarget(self, action: #selector(didchange(_:)), for: .valueChanged)
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        horizontalScrollView.delegate = self
        navigationItem.titleView = control
    }

    override func viewDidLayoutSubviews() {
        horizontalScrollView.frame = view.bounds
        
    }
    private func setUpFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        //
        setUpFollowingFeed()
        setUpFollowingYou()
    }
    @objc func didchange(_ sender:UISegmentedControl) {
        horizontalScrollView.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0), animated: false)
    }
    
   
    func setUpFollowingFeed() {
        //
        guard let model = followingposts.first else { return }
        let vc = PostViewController(model: model)
     
      
        forpagingController.setViewControllers([vc], direction: .forward, animated: false)
        vc.delegate = self
        forpagingController.dataSource = self
        horizontalScrollView.addSubview( forpagingController.view)
        forpagingController.view.frame = CGRect(x: 0, y: 0, width:horizontalScrollView.width, height: horizontalScrollView.height)
          addChild( forpagingController)
        forpagingController.didMove(toParent: self)
    }
    
    func setUpFollowingYou() {
        //
        guard let model = foryouposts.first else { return }
        let vc = PostViewController(model: model)
    
   
        folowwingpagingController.setViewControllers([vc], direction: .forward, animated: false)
        vc.delegate = self
        folowwingpagingController.dataSource = self
        horizontalScrollView.addSubview( folowwingpagingController.view)
        folowwingpagingController.view.frame = CGRect(x:view.width, y: 0, width:horizontalScrollView.width, height: horizontalScrollView.height)
        addChild( folowwingpagingController)
        folowwingpagingController.didMove(toParent: self)
      }
    
     
    
    }
   



extension HomeViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let frompost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index  = currentposts.firstIndex(where: {
            $0.identifier == frompost.identifier
        })else { return nil }
        guard index < (currentposts.count - 1) else { return nil}
        let priorined = index + 1
        let model = currentposts[priorined]
        let vc  = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let frompost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index  = currentposts.firstIndex(where: {
            $0.identifier == frompost.identifier
        })else { return nil }
                if index == 0 {
                    return nil
                }
        let priorined = index - 1
        let model = currentposts[priorined]
        let vc  = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    var currentposts:[PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            return followingposts
        }
        return foryouposts
        
    }
}


extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width/2) {
            control.selectedSegmentIndex = 0
        }else if scrollView.contentOffset.x  > (view.width/2){
            control.selectedSegmentIndex = 1
        }
    }
}

extension HomeViewController:PostViewControllerDelegate {
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel) {
      
        horizontalScrollView.isPagingEnabled = false
        if horizontalScrollView.contentOffset.x == 0 {
            forpagingController.dataSource = nil
        }else {
          
            folowwingpagingController.dataSource = nil
        }
        
        let vc = CommentViewController(post: post)
        vc.delegate = self
        addChild(vc)
        vc.didMove(toParent: self)
        view.addSubview(vc.view)
          let frame = CGRect(x: 0, y: CGFloat(Int(view.height)), width: view.width, height: view.height * 0.76)
        vc.view.frame = frame
        UIView.animate(withDuration: 0.2) {
            vc.view.frame = CGRect(x: 0, y: self.view.height - frame.height, width: frame.width, height: frame.height)
        }
    }
}

extension HomeViewController:CommentViewControllerdelegate {
    
    
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel) {
        let user = post.user
        let vc = ProfileViewController(user: user)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func closebutton(with viewController: CommentViewController) {
        let frame = viewController.view.frame
        
        UIView.animate(withDuration: 0.2) {
            viewController.view.frame = CGRect(x: 0, y: self.view.height, width: frame.width, height: frame.height)
            
            
        } completion: {[weak self] done in
            if done {
                DispatchQueue.main.async {
                    viewController.view.removeFromSuperview()
                    viewController.removeFromParent()
                    self?.horizontalScrollView.isPagingEnabled = true
                    self?.forpagingController.dataSource = self
                    self?.folowwingpagingController.dataSource = self
                }
            }
        }
    }
    
       
}
