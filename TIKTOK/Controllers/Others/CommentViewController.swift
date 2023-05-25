//
//  CommentViewController.swift
//  TIKTOK
//
//  Created by Apple on 22/05/2023.
//

import UIKit

protocol  CommentViewControllerdelegate {
    
    func closebutton(with viewController: CommentViewController)
    
}

class CommentViewController: UIViewController {
    private var comments = [PostComment]()
    
    private let post:PostModel
    
    var   delegate: CommentViewControllerdelegate?
    private let closeButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
        
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier:CommentTableViewCell.identifier)
        return tableView
        
    }()
    init(post:PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButton)
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        fetchpostComments()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    closeButton.frame = CGRect(x: view.width - 60, y: 5, width: 35, height: 35)
    tableView.frame = CGRect(x:0, y: closeButton.bottom, width: view.width, height: view.width - closeButton.bottom)
     
        
}
    
    private func fetchpostComments() {
        self.comments = PostComment.mockCommets()
    }

    @objc private func didTapClose() {
        delegate?.closebutton(with: self)
    }
    
}

extension CommentViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier,for: indexPath)  as? CommentTableViewCell  else {return UITableViewCell()}
      
        cell.configure(with:  comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
