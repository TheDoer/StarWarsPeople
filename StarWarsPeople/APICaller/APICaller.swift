//
//  APICaller.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 14/10/2021.
//

import Foundation

final class APICaller {
// no other class can inherit from this final class
    static let shared = APICaller()
    
    struct Constants {
        static let starWarsPeople = URL(string: "https://swapi.dev/api/people/")
    }
    
    private init(){}
    
    public func getStarWarsPeoplle(completion: @escaping (Swift.Result<[Result], Error>) -> Void) {
        guard let url = Constants.starWarsPeople else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                do {
                    let peopleResult = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("People: \( peopleResult.results!.count)")
                    completion(.success(peopleResult.results!))
                    
                }
                
                catch {
                    completion(.failure(error))
                }
            }
            
        }
        
        task.resume()
    }
    
}
