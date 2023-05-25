//
//  Explore Manager.swift
//  TIKTOK
//
//  Created by Apple on 23/05/2023.
//

import Foundation
import UIKit

// Delegate interface to notify manager events
protocol ExploreManagerDelegate: AnyObject {
    /// Notify a view controller should be pushed
    /// - Parameter vc: The view controller to present
    func pushViewController(_ vc: UIViewController)
    /// Notify a hashtag element was tapped
    /// - Parameter hashtag: The hashtag taht was tapped
    func didTapHashtag(_ hashtag: String)
}


final class ExploreManager {
    /// Shared singleton instance
    static let shared = ExploreManager()
    /// Delegate to notify of events
    weak var delegate: ExploreManagerDelegate?
    /// Represents banner action type
    enum BannerAction: String {
        /// Post type
        case post
        /// Hashtag search type
        case hashtag
        /// Creator type
        case user
    }
    
    /// Parse explore JSON data
    /// - Returns: Returns a optional response model
    private func parseExploreData() -> ExploreResponse? {
        guard let path = Bundle.main.path(forResource: "explore", ofType: "json") else {
            return nil
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(
                ExploreResponse.self,
                from: data
            )
        } catch {
            print(error)
            return nil
        }
    }
    
    
    public func getExploreBanners() -> [ExploreBannerViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.banners.compactMap({ model in
            ExploreBannerViewModel(
                imageView: UIImage(named: model.image),
                title: model.title
            ){
                
            }
            
            
        })
    }
    /// - Returns: Return collectiono of models
    public func getExploreCreators() -> [ExploreUserViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }

        return exploreData.creators.compactMap({ model in
            ExploreUserViewModel(
                profilePicture: UIImage(named: model.image),
                username: model.username,
                followerCuunt: model.followers_count
            ){
                
            }
        })
    }
    
    public func getExploreHashtags() -> [ExploreHashtagViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }

         return exploreData.hashtags.compactMap({ model in
            ExploreHashtagViewModel(text: "#" + model.tag, icon: UIImage(systemName: model.image), count: model.count) { [weak self] in
                DispatchQueue.main.async {
                    self?.delegate?.didTapHashtag(model.tag)
                }
            }
        })
    }
    public func getExploreTrendingPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.trendingPosts.compactMap({ model in
            ExplorePostViewModel(thumbimageView: UIImage(named: model.image), caption: model.caption
               ){
                
            }
        })
    }
    /// - Returns: Return collectiono of models
    public func getExploreRecentPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }

        return exploreData.recentPosts.compactMap({ model in
            ExplorePostViewModel(thumbimageView: UIImage(named: model.image), caption: model.caption){
                
            }
        })
    }
    public func getExplorePopularPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }

        return exploreData.popular.compactMap({ model in
            ExplorePostViewModel(thumbimageView: UIImage(named: model.image), caption: model.caption){
        }
    })
}
}
