//
//  ExploreHashTags.swift
//  TIKTOK
//
//  Created by Apple on 23/05/2023.
//

import Foundation
import UIKit

struct ExploreHashtagViewModel {
    let text:String
    let icon:UIImage?
    let count:Int //number of post assicited with tag
    let handler:(() -> Void)
}
