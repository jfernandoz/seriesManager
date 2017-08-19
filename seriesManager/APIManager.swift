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
    
    func getShow(withSeriesName: String){
        guard let url = buildURLWith(seriesName: withSeriesName) else{
            NSLog("Error building url")
            return
        }
        get(url: url, model: "Show")
    }
    
    func buildURLWith(seriesName: String) -> URL?{
        let seriesName = seriesName.replacingOccurrences(of: " ", with: "%20")
        let stringUrl = "\(APISettings.urlRequest)\(APISettings.apiKey)\(APISettings.title)\(seriesName)"
        if let result = URL(string: stringUrl){
            return result
        }
        return nil
    }
    
    func get(url: URL, model: String){
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
                
            }catch{
                NSLog("Error during parsing: ")
            }
            
        }
        
        task.resume()
        
    }
    
    func parse(json: [String: Any], model: String) -> AnyObject?{
        switch model {
        case "Show":
            let parsed = ShowModel.Parse(jsonShow: json)
            return parsed
        default:
            return nil
        }
    }
    
    func callDelegate(parsed: Any, model: String){
        switch model {
        case "Show":
            if let modelParsed = parsed as? ShowModel{
                self.delegate?.didReturnShow(show: modelParsed)
            }
            return
        default:
            return
        }

    }
    

}
