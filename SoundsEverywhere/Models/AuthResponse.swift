//
//  AuthResponse.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 2.11.21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in:Int
    let refresh_token: String
    let scope: String
    let token_type:String
}
