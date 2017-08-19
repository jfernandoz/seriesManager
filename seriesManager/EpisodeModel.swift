//
//  EpisodeModel.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

class EpisodeModel{
    
    var title: String?
    var rated: String?
    var released: Date?
    var season: Int?
    var episode: Int?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    var awards: String?
    var poster: String?
    var imdbrating: Double?
    
    init(){
        
    }
    
    init(title: String, rated: String, released: Date, season: Int, director: String, writer: String, actors: String, plot: String, language: String, country: String, awards: String, poster: String, imdbrating: Double){
        
        self.title = title
        self.rated = rated
        self.released = released
        self.season = season
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.imdbrating = imdbrating
        
    }
    
}
