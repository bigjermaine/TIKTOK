//
//  ExploreCell.swift
//  TIKTOK
//
//  Created by Apple on 25/05/2023.
//

import Foundation

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post (viewModel:ExplorePostViewModel)
    case hashtag (viewModel:ExploreHashtagViewModel)
    case user (viewModel: ExploreUserViewModel)
    
    
}
