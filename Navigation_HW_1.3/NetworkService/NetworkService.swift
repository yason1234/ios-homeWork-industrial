//
//  NetworkService.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 06.11.2022.
//

import Foundation

enum AppConfiguration {
    case first(url: String)
    case second(url: String)
    case third(url: String)
}

final class NetworkService {
    
    static func request(appConfiguration: AppConfiguration) {
        switch appConfiguration {
        case .first(let url):
            let url = URL(string: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url!) { data, response, error in
                
                if let error {
                    print(error.localizedDescription)
                }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let fields = (response as? HTTPURLResponse)?.allHeaderFields
                if statusCode != 200 {
                    print("status code = \(String(describing: statusCode))")
                }
                print(statusCode)
                print(fields)
                
                guard let data else {
                    print("data nil")
                    return
                }
                
                do {
                    if let answer = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                    let name = answer["name"] {
                        print(name)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        case .second(let url):
            let url = URL(string: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url!) { data, response, error in
                
                if let error {
                    print(error.localizedDescription)
                }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let fields = (response as? HTTPURLResponse)?.allHeaderFields
                if statusCode != 200 {
                    print("status code = \(String(describing: statusCode))")
                }
                print(statusCode)
                print(fields)
                
                guard let data else {
                    print("data nil")
                    return
                }
                
                do {
                    if let answer = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                       let name = answer["name"]  {
                        print(name)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
            
        case .third(let url):
            let url = URL(string: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url!) { data, response, error in
                
                if let error {
                    print(error.localizedDescription)
                }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let fields = (response as? HTTPURLResponse)?.allHeaderFields
                if statusCode != 200 {
                    print("status code = \(String(describing: statusCode))")
                }
                print(statusCode)
                print(fields)
                
                guard let data else {
                    print("data nil")
                    return
                }
                
                do {
                    if let answer = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                       let name = answer["name"]  {
                        print(name)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
