//
//  ShowModel.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

class ShowModel {
    
    var title: String?
    var year: String?
    var rated: String?
    var released: Date?
    var genre: String?
    var plot: String?
    var poster: String?
    var imdbRating: Double?
    var totalSeasons: Int?
    
    init() {
        
    }
    
    init(title: String, year: String, rated: String, released: Date, genre: String, plot: String, poster: String, imdbRating: Double, totalSeasons: Int){
        
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.genre = genre
        self.plot = plot
        self.poster = poster
        self.imdbRating = imdbRating
        self.totalSeasons = totalSeasons
        
    }
}
