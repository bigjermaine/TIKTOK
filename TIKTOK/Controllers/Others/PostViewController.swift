//
//  PostViewController.swift
//  TIKTOK
//
//  Created by Apple on 15/05/2023.
//

import UIKit
import AVFoundation


protocol  PostViewControllerDelegate:AnyObject {
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel)
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel)
}

class PostViewController: UIViewController {
    
    var model:PostModel
    
    weak var delegate: PostViewControllerDelegate?
    var player:AVPlayer?
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    private let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        return view
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person"),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    private let captionLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Naruto Trending Right Now"
        label.textColor = .white
        return label
    }()
    init(model: PostModel){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        configureVideo()
        let colors:[UIColor] = [.red,.blue,.black,.gray,.orange]
        
        view.backgroundColor = colors.randomElement()
        setup()
        setupDoubleTap()
        view.addSubview(captionLabel)
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        configureVideo()
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)
        view.addSubview(profileButton)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didshareButton), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
      
    }
    func configureVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {return}
        
        let url  = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        player?.externalPlaybackVideoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        player?.volume = 1 
        player?.play()
        
        
        
    }
    @objc func didTapProfile() {
        
        delegate?.postViewController(self, didTapProfileButtonFor: model)
        
    }
    @objc func didTapLike() {
        model.islikedByCurrenuser = !model.islikedByCurrenuser
        likeButton.tintColor = model.islikedByCurrenuser ? .systemRed : .white
    }
    @objc func didTapComment() {
        delegate?.postViewController(self, didTapCommentButtonFor: model)
        
    }
    @objc func didshareButton() {
        guard let url =  URL(string: "https://www.tiktok.com") else { return}
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size:CGFloat = 30
        let ystart:CGFloat = view.height - (size*4) - 30 - view.safeAreaInsets.bottom  - 50
        for (index,button) in [likeButton,commentButton,shareButton].enumerated() {
            button.frame = CGRect(x: CGFloat(Int(view.width-size)-5), y: ystart+(CGFloat(index)*size), width: size, height: size)
        }
        
        captionLabel.sizeToFit()
        let labelHeight = captionLabel.sizeThatFits(CGSize(width: view.width-size-12, height: view.height))
        captionLabel.frame = CGRect(x: 5, y: Int(view.height - 10 - view.safeAreaInsets.bottom - labelHeight.height) - Int((tabBarController?.tabBar.height ?? 0)), width: Int(view.width-size)-12 , height:  Int(labelHeight.height))
        
        profileButton.frame = CGRect(x: likeButton.left, y: likeButton.top - 10 - size, width: size, height: size)
        profileButton.layer.cornerRadius = profileButton.height/2
    }
    func  setupDoubleTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    @objc private func didDoubleTap(_ gesture:UITapGestureRecognizer) {
        if !model.islikedByCurrenuser {
            model.islikedByCurrenuser = true
        }
        
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .systemRed
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = touchPoint
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        view.addSubview(imageView)
        UIView.animate(withDuration: 0.2) {
            imageView.alpha = 1
        }completion: {
            done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0
                    }completion: { done in
                        if done {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}
