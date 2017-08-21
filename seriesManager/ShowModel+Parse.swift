//
//  ShowModel+Parse.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

extension ShowModel{

    static func Parse(jsonShow: [String: Any]) -> ShowModel {
        let result = ShowModel()
        if let releasedDate = jsonShow[APISettings.releasedKey] as? String {
            let df = DateFormatter()
            df.dateFormat = APISettings.dateAPIFormat
            result.released = df.date(from: releasedDate)
        }
        if let rating = jsonShow[APISettings.imdbRatingKey] as? String {
            result.imdbRating = Double(rating)
        }
        if let numOfSeasons = jsonShow[APISettings.totalSeasonsKey] as? String {
            result.totalSeasons = Int(numOfSeasons)
        }
        result.genre = jsonShow[APISettings.genreKey] as? String
        result.plot = jsonShow[APISettings.plotKey] as? String
        result.poster = jsonShow[APISettings.posterKey] as? String
        result.rated = jsonShow[APISettings.ratedKey] as? String
        result.title = jsonShow[APISettings.titleKey] as? String
        result.year = jsonShow[APISettings.yearKey] as? String
        return result
    }
    
}
