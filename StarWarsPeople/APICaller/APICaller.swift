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
    
    private init(){}
    
    public func getStarWarsPeople(completion: @escaping (Swift.Result<[Result], Error>) -> Void) {
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
    
    public func searchWithName(with query: String, completion: @escaping (Swift.Result<[Result], Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urltring = Constants.searchURLString + query
        guard let url = URL(string: urltring) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                do {
                    
                    let results = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("PeopleNow: \(results.results?.count)")
                    completion(.success(results.results!))
                }
                catch {
                    completion(.failure(error))
            }
        }
    }
        
   task.resume()
        
    }
}
