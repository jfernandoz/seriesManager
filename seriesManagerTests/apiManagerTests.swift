//
//  apiManagerTests.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import XCTest
@testable import seriesManager

class apiManagerTests: XCTestCase {
    var api = APIManager()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildShowUrl(){
        let result = api.buildURLWith(seriesName: "Game of Thrones", seasonNumber: nil, episodeNumber: nil)?.absoluteString ?? ""
        XCTAssert(result == "https://www.omdbapi.com/?apikey=6bfb4e66&t=Game%20of%20Thrones", "Failed to build show URL")
    }
    
    func testParseShow(){
        let json = ["Title":"Game of Thrones","Year":"2011–","Rated":"TV-MA","Released":"17 Apr 2011","Runtime":"57 min","Genre":"Adventure, Drama, Fantasy","Director":"N/A","Writer":"David Benioff, D.B. Weiss","Actors":"Peter Dinklage, Lena Headey, Emilia Clarke, Kit Harington","Plot":"Nine noble families fight for control over the mythical lands of Westeros, while a forgotten race returns after being dormant for thousands of years.","Language":"English","Country":"USA, UK","Awards":"Won 1 Golden Globe. Another 246 wins & 414 nominations.","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTQ1NDg1Ml5BMl5BanBnXkFtZTgwNzY2NDA0MjI@._V1_SX300.jpg","Ratings":[["Source":"Internet Movie Database","Value":"9.5/10"]],"Metascore":"N/A","imdbRating":"9.5","imdbVotes":"1,203,942","imdbID":"tt0944947","Type":"series","totalSeasons":"8","Response":"True"] as [String : Any]
    
        let result = ShowModel.Parse(jsonShow: json)
        
        let df = DateFormatter()
        df.dateFormat = APISettings.dateAPIFormat

        XCTAssert(result.title == "Game of Thrones" && result.year == "2011–" && result.rated == "TV-MA" && result.released == df.date(from: "17 Apr 2011") && result.genre == "Adventure, Drama, Fantasy" && result.plot == "Nine noble families fight for control over the mythical lands of Westeros, while a forgotten race returns after being dormant for thousands of years." && result.poster == "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTQ1NDg1Ml5BMl5BanBnXkFtZTgwNzY2NDA0MjI@._V1_SX300.jpg" && result.imdbRating == 9.5 && result.totalSeasons == 8, "Parsing failed")

    }
    
    func testBuildSeasonUrl(){
        let result = api.buildURLWith(seriesName: "Game of Thrones", seasonNumber: 1, episodeNumber: nil)?.absoluteString ?? ""
        XCTAssert(result == "https://www.omdbapi.com/?apikey=6bfb4e66&t=Game%20of%20Thrones&season=1", "Failed to build season URL")
    }
    
    func testParseSeason(){
        let json = ["Title":"Game of Thrones","Season":"1","totalSeasons":"8","Episodes":[["Title":"Winter Is Coming","Released":"2011-04-17","Episode":"1","imdbRating":"9.0","imdbID":"tt1480055"],["Title":"The Kingsroad","Released":"2011-04-24","Episode":"2","imdbRating":"8.8","imdbID":"tt1668746"],["Title":"Lord Snow","Released":"2011-05-01","Episode":"3","imdbRating":"8.7","imdbID":"tt1829962"],["Title":"Cripples, Bastards, and Broken Things","Released":"2011-05-08","Episode":"4","imdbRating":"8.8","imdbID":"tt1829963"],["Title":"The Wolf and the Lion","Released":"2011-05-15","Episode":"5","imdbRating":"9.1","imdbID":"tt1829964"],["Title":"A Golden Crown","Released":"2011-05-22","Episode":"6","imdbRating":"9.2","imdbID":"tt1837862"],["Title":"You Win or You Die","Released":"2011-05-29","Episode":"7","imdbRating":"9.2","imdbID":"tt1837863"],["Title":"The Pointy End","Released":"2011-06-05","Episode":"8","imdbRating":"9.0","imdbID":"tt1837864"],["Title":"Baelor","Released":"2011-06-12","Episode":"9","imdbRating":"9.6","imdbID":"tt1851398"],["Title":"Fire and Blood","Released":"2011-06-19","Episode":"10","imdbRating":"9.5","imdbID":"tt1851397"]],"Response":"True"] as [String: Any]
        
        let result = SeasonModel.Parse(jsonSeason: json)
        XCTAssert(result.season == 1 && result.episodes?.count==10, "Parsing failed")
        
    }

    func testBuildEpisodeUrl(){
        let result = api.buildURLWith(seriesName: "Game of Thrones", seasonNumber: 1, episodeNumber: 1)?.absoluteString ?? ""
        XCTAssert(result == "https://www.omdbapi.com/?apikey=6bfb4e66&t=Game%20of%20Thrones&season=1&episode=1", "Failed to build season URL")
    }
    
    func testParseEpisode(){
        let json = ["Title":"Winter Is Coming","Year":"2011","Rated":"TV-MA","Released":"17 Apr 2011","Season":"1","Episode":"1","Runtime":"62 min","Genre":"Adventure, Drama, Fantasy","Director":"Timothy Van Patten","Writer":"David Benioff (created by), D.B. Weiss (created by), George R.R. Martin (based on \"A Song of Ice and Fire\" by), David Benioff, D.B. Weiss","Actors":"Sean Bean, Mark Addy, Nikolaj Coster-Waldau, Michelle Fairley","Plot":"Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.","Language":"English","Country":"USA","Awards":"N/A","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTk5MDU3OTkzMF5BMl5BanBnXkFtZTcwOTc0ODg5NA@@._V1_SX300.jpg","Ratings":[["Source":"Internet Movie Database","Value":"9.0/10"]],"Metascore":"N/A","imdbRating":"9.0","imdbVotes":"21370","imdbID":"tt1480055","seriesID":"tt0944947","Type":"episode","Response":"True"] as [String: Any]
        
        let result = EpisodeModel.Parse(jsonEpisode: json)
        
        let df = DateFormatter()
        df.dateFormat = APISettings.dateAPIFormat
        
        XCTAssert(result.title == "Winter Is Coming" && result.rated == "TV-MA" && result.released == df.date(from: "17 Apr 2011") && result.season == 1 && result.episode == 1 && result.director == "Timothy Van Patten" && result.writer == "David Benioff (created by), D.B. Weiss (created by), George R.R. Martin (based on \"A Song of Ice and Fire\" by), David Benioff, D.B. Weiss" && result.actors == "Sean Bean, Mark Addy, Nikolaj Coster-Waldau, Michelle Fairley" && result.plot == "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army." && result.language == "English" && result.country == "USA" && result.awards == "N/A" && result.poster == "https://images-na.ssl-images-amazon.com/images/M/MV5BMTk5MDU3OTkzMF5BMl5BanBnXkFtZTcwOTc0ODg5NA@@._V1_SX300.jpg" && result.imdbrating == 9.0, "Parsing failed")
    }
}
