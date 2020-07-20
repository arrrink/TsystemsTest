//
//  Movie.swift
//  TsystemsTest
//
//  Created by Арина Нефёдова on 18.07.2020.
//  Copyright © 2020 Арина Нефёдова. All rights reserved.
//

import Foundation

struct Movie {
    
    static var numberOfMovies = 0
    
    var original_title: String
    var release_date: String
    var poster_path: String
    var overview: String
    var rate: Double
    
    init(original_title: String,
     release_date: String,
    poster_path: String,
     overview: String,
    rate: Double) {
        self.original_title = original_title
        self.release_date = release_date
        self.poster_path = poster_path
        self.overview = overview
        self.rate = rate
        
        Movie.numberOfMovies += 1
        
    }
}
