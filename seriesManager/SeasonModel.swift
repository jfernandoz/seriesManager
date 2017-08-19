//
//  SeasonModel.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

class SeasonModel{
    
    var season: Int?
    var episodes: [String: String]?
    
    init() {
    
    }
    
    init(season: Int, episodes: [String:String]){
        self.season = season
        self.episodes = episodes
    }
}
