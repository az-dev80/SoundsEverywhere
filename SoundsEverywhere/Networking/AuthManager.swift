//
//  AuthManager.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import Foundation
import UIKit
import CoreData

final class AuthManager {
    static let shared = AuthManager()
    private var refreshingToken = false
    var authData: [AuthData] = []
    
    struct Constants {
        static let clientID = "0nCAtptiFhJ9gn1kYZ5j"
        static let clientSecret = "K3uF2Ffvxn9qoJoSCwWolSiVp6n2WneA19doDGKJ"
        static let tokenAPIURL = "https://freesound.org/apiv2/oauth2/access_token/"
    }
    
    public var signInURL: URL? {
        let base = "https://freesound.org/apiv2/oauth2/logout_and_authorize/?"
        let parameter1 = "response_type=code"
        let parameter2 = "client_id=\(Constants.clientID)"
        let string = "\(base)" + parameter1 + "&" + parameter2
        return URL(string: string)
    }
    
    var isSignedIn: Bool { return accessToken != nil }
    
    private var accessToken: String? {
       getAuthData { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let authData):
                    self.authData = authData ?? []
                    print("Au1: \(authData)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return authData.last?.value(forKeyPath: "access_token") as? String
        //UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        getAuthData { [weak self] result in
             guard let self = self else {return}
             DispatchQueue.main.async {
                 switch result {
                 case .success(let authData):
                     self.authData = authData ?? []
                    print("Au2: \(authData)")
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
         }
         return authData.last?.value(forKeyPath: "refresh_token") as? String
        //UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        getAuthData { [weak self] result in
             guard let self = self else {return}
             DispatchQueue.main.async {
                 switch result {
                 case .success(let authData):
                     self.authData = authData ?? []
                    print("Au3: \(authData)")
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
         }
         return authData.last?.value(forKeyPath: "expirationDate") as? Date
        //UserDefaults.standard.object(forKey: "rexpirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        return currentDate.addingTimeInterval(300) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping((Bool)->Void)) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "client_id", value: Constants.clientID),
            URLQueryItem(name: "client_secret", value: Constants.clientSecret),
            URLQueryItem(name: "code", value: code)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                //print("TTTTTOKENNNNNNNNNNN: \(json)")
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print(result)
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshAccessToken { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard !refreshingToken else { return }
        
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else { return }
        
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "client_id", value: Constants.clientID),
            URLQueryItem(name: "client_secret", value: Constants.clientSecret),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.refreshingToken = false
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Successfully refreshed")
                self?.onRefreshBlocks.forEach { $0(result.access_token) }
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }

    func cacheToken(result: AuthResponse) {
        DispatchQueue.main.async(execute: {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let container = NSPersistentContainer(name: "storage")
            guard let entity = NSEntityDescription.entity(forEntityName: "AuthData", in: managedContext) else { return }
            let authData = AuthData(entity: entity, insertInto: managedContext)
            
            //access_token = result.access_token
            authData.setValue(result.access_token, forKeyPath: "access_token")
            authData.setValue(result.refresh_token, forKeyPath: "refresh_token")
            authData.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKeyPath: "expirationDate")
            do {
                try managedContext.save()
               // wallets.append(wallet)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        })
        
//        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
//        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
//        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
    func getAuthData(completion: @escaping (Result<[AuthData]?, Error>) -> (Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AuthData>(entityName: "AuthData")
        do {
            authData = try managedContext.fetch(fetchRequest)
            completion(.success(authData))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }
    
}
