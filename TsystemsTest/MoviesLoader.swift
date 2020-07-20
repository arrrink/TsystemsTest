//
//  MoviesLoader.swift
//  TsystemsTest
//
//  Created by Арина Нефёдова on 18.07.2020.
//  Copyright © 2020 Арина Нефёдова. All rights reserved.
//

import Foundation

class MoviesLoader {
    
    func loadMovies(completition: @escaping ([Movie]) -> Void) {
       
        
        var movies: [Movie] = []
        
        for i in 1...500 {
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a355070e5cac08d6f012cdb7d92f1805&language=en-US&primary_release_year=2019&page=\(i)&sort_by=vote_average.desc")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                let results = json["results"] as! Array<Dictionary<String, AnyObject >>
                
                
                for (i, _) in results.enumerated() {
                        
                    let movie = Movie(original_title: results[i]["title"]! as! String,
                                    
                                      release_date: results[i]["release_date"]! as! String,
                                      poster_path: results[i]["poster_path"] as? String ?? "",
                                      overview: results[i]["overview"]! as! String,
                                      rate: results[i]["vote_average"]! as! Double)
                    movies.append(movie)
                }
                
                
                } catch {
                print("Can't parse responce.")
                }

            DispatchQueue.main.async {
                completition(movies)
            }
                
        }
        task.resume()
        
    }
        
    }
}

