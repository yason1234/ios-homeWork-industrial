//
//  Network JSON.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 09.11.2022.
//

import Foundation

/*
 "userId": 1,
   "id": 3,
   "title": "fugiat veniam minus",
   "completed": false
 */

final class NetworkJson {
    
    func jsonRequest(completion: ((String?) -> Void)?) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/3") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("statusCode != 200")
            }
            
            guard let data else {
                print("data is nil")
                return
            }
            
            do {
                if let result = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                    completion?(result["title"] as? String)
                }
            } catch {
                error.localizedDescription
            }
        }
        task.resume()
    }
}
