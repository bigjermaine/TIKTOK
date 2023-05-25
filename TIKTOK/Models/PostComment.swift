//
//  PostComment.swift
//  TIKTOK
//
//  Created by Apple on 22/05/2023.
//

import Foundation


struct PostComment {
    let text:String
    let user:User
    let date:Date
    
    static func mockCommets() -> [PostComment] {
        return [
         PostComment(text: "jermaine", user: User(username: "jermaine", profilePictureURL: nil, identifier: "ee"), date:Date())]
    }
}
