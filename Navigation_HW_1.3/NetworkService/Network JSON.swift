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
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

/*
 {
     "name": "Tatooine",
     "rotation_period": "23",
     "orbital_period": "304",
     "diameter": "10465",
     "climate": "arid",
     "gravity": "1 standard",
     "terrain": "desert",
     "surface_water": "1",
     "population": "200000",
     "residents": [
         "https://swapi.dev/api/people/1/",
         "https://swapi.dev/api/people/2/",
         "https://swapi.dev/api/people/4/",
         "https://swapi.dev/api/people/6/",
         "https://swapi.dev/api/people/7/",
         "https://swapi.dev/api/people/8/",
         "https://swapi.dev/api/people/9/",
         "https://swapi.dev/api/people/11/",
         "https://swapi.dev/api/people/43/",
         "https://swapi.dev/api/people/62/"
     ],
     "films": [
         "https://swapi.dev/api/films/1/",
         "https://swapi.dev/api/films/3/",
         "https://swapi.dev/api/films/4/",
         "https://swapi.dev/api/films/5/",
         "https://swapi.dev/api/films/6/"
     ],
     "created": "2014-12-09T13:50:49.641000Z",
     "edited": "2014-12-20T20:58:18.411000Z",
     "url": "https://swapi.dev/api/planets/1/"
 }
 */

final class NetworkJSONCodable {
    
    struct Planet: Decodable {
        var name: String
        var orbital_period: String
        var residents: [String]
    }
    
    struct Resident: Decodable {
        var name: String
    }
    
    func parsingPlanet(completion: ( (String, [String]) -> Void)? ) {
        
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
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
                let planet = try JSONDecoder().decode(Planet.self, from: data)
                self?.parsingResidents(url: planet.residents) { arrayRes in
                    completion?(planet.orbital_period, arrayRes)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func parsingResidents(url: [String], completion: ( ([String]) -> Void)? ) {
       var arrayResident = [String]()
        for urlRes in url {
            
            guard let url = URL(string: urlRes) else {return}
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
                    let resident = try JSONDecoder().decode(Resident.self, from: data)
                    arrayResident.append(resident.name)
                    completion?(arrayResident)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
