//
//  APICaller.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 2.11.21.
//

import Foundation

 class APICaller {
    static let shared = APICaller()
    
    init(){}
    
    struct  Constants {
        static let baseURLAPI = "https://freesound.org/apiv2/"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURLAPI + "me/"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    public func getLastSounds(completion: @escaping ((Result<LastSoundsModel, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURLAPI + "search/text/?fields=name,pack,avg_rating,license,username,download,previews,images,bookmark,created,type,url,id,num_downloads,duration&page=1&page_size=10&sort=created_desc"),
            type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LastSoundsModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getTopRatedSounds(completion: @escaping ((Result<TopRatedSoundsModel, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURLAPI + "search/text/?query=&filter=avg_rating:[8%20TO%2010]&fields=name,pack,avg_rating,license,username,download,previews,images,bookmark,created,type,url,id,num_downloads,duration&page=1&page_size=12&sort=downloads_desc"),
            type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(TopRatedSoundsModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategorySounds(category: String, completion: @escaping ((Result<LastSoundsModel, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURLAPI + "search/text/?query=&filter=tag:\(category)&fields=name,pack,avg_rating,license,username,download,previews,images,bookmark,created,type,url,id,num_downloads,duration&page=1&page_size=40&sort=downloads_desc"),
            type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LastSoundsModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func searchSounds(query: String, completion: @escaping ((Result<LastSoundsModel, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURLAPI + "search/text/?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&fields=name,pack,avg_rating,license,username,download,previews,images,bookmark,created,type,url,id,num_downloads,duration&page=1&page_size=40&sort=downloads_desc"),
            type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LastSoundsModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
     func createRequest(with url: URL?, type: HTTPMethod,completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            //request.timeoutInterval = 30
            completion(request)
        }
    }
}

