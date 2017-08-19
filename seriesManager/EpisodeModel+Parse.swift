//
//  EpisodeModel+Parse.swift
//  seriesManager
//
//  Created by MCS on 8/19/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

extension EpisodeModel{
    
    static func Parse(jsonEpisode: [String: Any]) -> EpisodeModel {
        let result = EpisodeModel()
        
        if let releasedDate = jsonEpisode[APISettings.releasedKey] as? String{
            let df = DateFormatter()
            df.dateFormat = APISettings.dateAPIFormat
            result.released = df.date(from: releasedDate)
        }
        if let season = jsonEpisode[APISettings.seasonNumKey] as? String{
            result.season = Int(season)
        }
        if let episode = jsonEpisode[APISettings.episodeKey] as? String{
            result.episode = Int(episode)
        }
        if let rating = jsonEpisode[APISettings.imdbRatingKey] as? String{
            result.imdbrating = Double(rating)
        }
        result.title = jsonEpisode[APISettings.titleKey] as? String
        result.rated = jsonEpisode[APISettings.ratedKey] as? String
        result.director = jsonEpisode[APISettings.directorKey] as? String
        result.writer = jsonEpisode[APISettings.writerKey] as? String
        result.actors   = jsonEpisode[APISettings.actorsKey] as? String
        result.plot = jsonEpisode[APISettings.plotKey] as? String
        result.language = jsonEpisode[APISettings.languageKey] as? String
        result.country = jsonEpisode[APISettings.countryKey] as? String
        result.awards = jsonEpisode[APISettings.awardsKey] as? String
        result.poster = jsonEpisode[APISettings.posterKey] as? String
        return result
    }
    
}
