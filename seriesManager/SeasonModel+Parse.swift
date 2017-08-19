//
//  SeasonModel+Parse.swift
//  seriesManager
//
//  Created by MCS on 8/19/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

extension SeasonModel{
    
    static func Parse(jsonSeason: [String: Any]) -> SeasonModel {
        let result = SeasonModel()
        if let numberOfSeason = jsonSeason[APISettings.seasonNumKey] as? String {
            result.season = Int(numberOfSeason)
        }
        result.episodes = jsonSeason[APISettings.seasonEpisodesKey] as? [[String: String]]
        return result
    }
    
    
}
