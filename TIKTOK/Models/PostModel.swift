//
//  PostModel.swift
//  TIKTOK
//
//  Created by Apple on 16/05/2023.
//

import Foundation

struct PostModel {
    
    let identifier:String
    var islikedByCurrenuser = false
    let user = User(username: "Kanye West", profilePictureURL: nil, identifier: UUID().uuidString)
    static func mockmodels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
        let post  =  PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
    
    
    
}
