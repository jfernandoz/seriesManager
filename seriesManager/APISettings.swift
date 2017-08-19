//
//  APISettings.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

struct APISettings{
    
    //API settings
    static let urlRequest = "https://www.omdbapi.com/"
    static let apiKey = "?apikey=6bfb4e66&"
    static let titleEquals = "t="
    static let seasonEquals = "season="
    static let episodeEquals = "episode="
    static let appender = "&"
    static let dateAPIFormat = "dd MMM yyyy"
    
    //Request identifiers
    static let titleKey = "Title"
    static let yearKey = "Year"
    static let ratedKey = "Rated"
    static let releasedKey = "Released"
    static let genreKey = "Genre"
    static let plotKey = "Plot"
    static let posterKey = "Poster"
    static let imdbRatingKey = "imdbRating"
    static let totalSeasonsKey = "totalSeasons"
    static let seasonNumKey = "Season"
    static let seasonEpisodesKey = "Episodes"
    static let episodeKey = "Episode"
    static let directorKey = "Director"
    static let writerKey = "Writer"
    static let actorsKey = "Actors"
    static let languageKey = "Language"
    static let countryKey = "Country"
    static let awardsKey = "Awards"
    
    enum model {
        case show
        case season
        case episode
    }

    
}
