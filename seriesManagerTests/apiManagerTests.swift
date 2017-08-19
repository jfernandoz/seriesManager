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
        let result = api.buildURLWith(seriesName: "Game of Thrones")?.absoluteString ?? ""
        XCTAssert(result == "https://www.omdbapi.com/?apikey=6bfb4e66&t=Game%20of%20Thrones", "Failed to build show URL")
    }
    
    func testParseShow(){
        let json = ["Title":"Game of Thrones","Year":"2011–","Rated":"TV-MA","Released":"17 Apr 2011","Runtime":"57 min","Genre":"Adventure, Drama, Fantasy","Director":"N/A","Writer":"David Benioff, D.B. Weiss","Actors":"Peter Dinklage, Lena Headey, Emilia Clarke, Kit Harington","Plot":"Nine noble families fight for control over the mythical lands of Westeros, while a forgotten race returns after being dormant for thousands of years.","Language":"English","Country":"USA, UK","Awards":"Won 1 Golden Globe. Another 246 wins & 414 nominations.","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTQ1NDg1Ml5BMl5BanBnXkFtZTgwNzY2NDA0MjI@._V1_SX300.jpg","Ratings":[["Source":"Internet Movie Database","Value":"9.5/10"]],"Metascore":"N/A","imdbRating":"9.5","imdbVotes":"1,203,942","imdbID":"tt0944947","Type":"series","totalSeasons":"8","Response":"True"] as [String : Any]
    
        let model = "Show"
        let result = api.parse(json: json, model: model) as! ShowModel
        
        let df = DateFormatter()
        df.dateFormat = APISettings.dateAPIFormat

        XCTAssert(result.title == "Game of Thrones" && result.year == "2011–" && result.rated == "TV-MA" && result.released == df.date(from: "17 Apr 2011") && result.genre == "Adventure, Drama, Fantasy" && result.plot == "Nine noble families fight for control over the mythical lands of Westeros, while a forgotten race returns after being dormant for thousands of years." && result.poster == "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTQ1NDg1Ml5BMl5BanBnXkFtZTgwNzY2NDA0MjI@._V1_SX300.jpg" && result.imdbRating == 9.5 && result.totalSeasons == 8, "Parsing failed")

    }
}
