//
//  ExploreuserViewModel.swift
//  TIKTOK
//
//  Created by Apple on 23/05/2023.
//

import Foundation
import UIKit

struct ExploreUserViewModel {
    let profilePicture: UIImage?
    let username: String
    let followerCuunt: Int
    let handler: (() -> Void)
}
