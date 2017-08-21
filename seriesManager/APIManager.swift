//
//  APIManager.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

class APIManager{
    
    weak var delegate:APIDelegate?
    
    func getShow(withSeriesName: String) {
        guard let url = buildURLWith(seriesName: withSeriesName) else{
            NSLog("Error building url")
            return
        }
        get(url: url, model: APISettings.model.show)
    }
    
    func getSeason(withSeriesName: String, seasonNumber: Int) {
        guard let url = buildURLWith(seriesName: withSeriesName, seasonNumber: seasonNumber) else{
            NSLog("Error building url")
            return
        }
        get(url: url, model: APISettings.model.season)
    }
    
    func getEpisode(withSeriesName: String, seasonNumber: Int, episodeNumber: Int) {
        guard let url = buildURLWith(seriesName: withSeriesName, seasonNumber: seasonNumber, episodeNumber: episodeNumber) else{
            NSLog("Error building url")
            return
        }
        get(url: url, model: APISettings.model.episode)
    }
    
    func getEpisode(withId: String) {
        guard let url = buildURL(withId: withId) else{
            NSLog("Error building url")
            return
        }
        get(url: url, model: APISettings.model.episode)
    }
    
    func buildURL(withId: String) -> URL? {
        let stringUrl = "\(APISettings.urlRequest)\(APISettings.apiKey)\(APISettings.itemEquals)\(withId)"
        if let result = URL(string: stringUrl) {
            return result
        }
        return nil
    }
    
    func buildURLWith(seriesName: String) -> URL? {
        return buildURLWith(seriesName: seriesName, seasonNumber: nil, episodeNumber: nil)
    }
    
    func buildURLWith(seriesName: String, seasonNumber: Int?) -> URL? {
        return buildURLWith(seriesName: seriesName, seasonNumber: seasonNumber, episodeNumber: nil)
    }
    
    func buildURLWith(seriesName: String, seasonNumber: Int?, episodeNumber: Int?) -> URL? {
        let seriesName = seriesName.replacingOccurrences(of: " ", with: "%20")
        var stringUrl = "\(APISettings.urlRequest)\(APISettings.apiKey)\(APISettings.titleEquals)\(seriesName)"
        if let seasonNumber = seasonNumber{
            stringUrl.append("\(APISettings.appender)\(APISettings.seasonEquals)\(seasonNumber)")
            if let episodeNumber = episodeNumber{
                stringUrl.append("\(APISettings.appender)\(APISettings.episodeEquals)\(episodeNumber)")
            }
        }
        
        if let result = URL(string: stringUrl) {
            return result
        }
        return nil
    }
    
    func get(url: URL, model: APISettings.model) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else{
                NSLog("Error description: ", error.debugDescription)
                return
            }
            do{
                guard let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else{
                    NSLog("No JSON retrieved")
                    return
                }
                DispatchQueue.main.async {
                    guard let parsed = self.parse(json: json, model: model) else{
                        return
                    }
                    self.callDelegate(parsed: parsed, model: model)
                }
            }catch {
                NSLog("Error during parsing: ")
            }
        }
        
        task.resume()
        
    }
    
    func parse(json: [String: Any], model: APISettings.model) -> AnyObject? {
        var parsed:AnyObject? = nil
        switch model {
        case .show:
            parsed = ShowModel.Parse(jsonShow: json)
        case .season:
            parsed = SeasonModel.Parse(jsonSeason: json)
        case .episode:
            parsed = EpisodeModel.Parse(jsonEpisode: json)
        }
        return parsed
    }
    
    func callDelegate(parsed: Any, model: APISettings.model) {
        switch model {
        case .show:
            if let modelParsed = parsed as? ShowModel {
                self.delegate?.didReturnShow(show: modelParsed)
            }
        case .season:
            if let modelParsed = parsed as? SeasonModel {
                self.delegate?.didReturnSeason(season: modelParsed)
            }
        case .episode:
            if let modelParsed = parsed as? EpisodeModel {
                self.delegate?.didReturnEpisode(episode: modelParsed)
            }
        }
        return
    }
    

}
