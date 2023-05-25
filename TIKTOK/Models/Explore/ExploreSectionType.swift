//
//  ExploreSectionType.swift
//  TIKTOK
//
//  Created by Apple on 23/05/2023.
//

import Foundation
import UIKit

enum ExploreSectionType {
    case banners
    case trendingposts
    case trendingHashTags
    case recommended
    case popular
    case new
    case users
    var title:String {
        switch self{
        
        case .banners:
            return "banners"
        case .trendingposts:
            return "trending posts"
        case .trendingHashTags:
            return "trendingHashTags"
        case .recommended:
            return "recommended"
        case .popular:
            return "popular"
        case .new:
            return "new"
        case .users:
            return "users"
        }
    }
}

