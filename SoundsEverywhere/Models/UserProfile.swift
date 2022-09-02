//
//  UserProfile.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 3.11.21.
//

import Foundation

struct UserProfile: Codable {
    let url: String
    let username, about, homePage: String
    let avatar: Avatar
    let dateJoined: String
    let numSounds: Int
    let sounds: String
    let numPacks: Int
    let packs: String
    let numPosts, numComments: Int
    let bookmarkCategories: String
    let email: String
    let uniqueID: Int
    
    enum CodingKeys: String, CodingKey {
        case url, username, about
        case homePage = "home_page"
        case avatar
        case dateJoined = "date_joined"
        case numSounds = "num_sounds"
        case sounds
        case numPacks = "num_packs"
        case packs
        case numPosts = "num_posts"
        case numComments = "num_comments"
        case bookmarkCategories = "bookmark_categories"
        case email
        case uniqueID = "unique_id"
    }
}

struct Avatar: Codable {
    let small, large, medium: String
}
//avatar =     {
//    large = "https://freesound.org/media/images/70x70_avatar.png";
//    medium = "https://freesound.org/media/images/40x40_avatar.png";
//    small = "https://freesound.org/media/images/32x32_avatar.png";
//};
//"bookmark_categories" = "https://freesound.org/apiv2/users/testID1/bookmark_categories/";

// = "finderaz@yandex.ru";
//"home_page" = "";
//"num_comments" = 0;
//"num_packs" = 0;
//"num_posts" = 0;
//"num_sounds" = 0;
//packs = "https://freesound.org/apiv2/users/testID1/packs/";
//sounds = "https://freesound.org/apiv2/users/testID1/sounds/";



