//
//  CommentTableViewCell.swift
//  TIKTOK
//
//  Created by Apple on 22/05/2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let identifier = "CommentTableViewCell"
    
    private let avartarImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let commentlabel:UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    private let datelabel:UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avartarImageView)
        contentView.addSubview(commentlabel)
        contentView.addSubview(datelabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        commentlabel.sizeToFit()
        datelabel.sizeToFit()
     
           let imageSize:CGFloat = 35
        
        let commentLabelHeight = min(contentView.height - datelabel.top, commentlabel.height)
        
        avartarImageView.frame = CGRect(x: 10, y: 15, width: imageSize, height: imageSize)
        datelabel.frame = CGRect(x: avartarImageView.right + 10, y: commentlabel.bottom, width: datelabel.width, height: datelabel.height)
        commentlabel.frame = CGRect(x: avartarImageView.right+10, y: 5, width: contentView.width - avartarImageView.right - 10, height: commentLabelHeight)
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        datelabel.text = nil
        commentlabel.text = nil
        avartarImageView.image = nil
    }
    
    
    
    public func configure(with model: PostComment) {
        commentlabel.text = model.text
        
        if let url =  model.user.profilePictureURL {
            let urlstring = url.absoluteString
            print(url)
        }else {
            avartarImageView.image = UIImage(systemName: "person")
        }
        datelabel.text = .date(with: model.date)
       
    }
}
