//
//  StarRating.swift
//  seriesManager
//
//  Created by MCS on 8/21/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class StarRating: UIView {
    @IBOutlet var starView: UIView!

    @IBOutlet weak var starOne: UIImageView!
    @IBOutlet weak var starTwo: UIImageView!
    @IBOutlet weak var starThree: UIImageView!
    @IBOutlet weak var starFour: UIImageView!
    @IBOutlet weak var starFive: UIImageView!
    
    @IBOutlet weak var imdbRating: UILabel!
    /*

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("StarRating", owner: self, options: nil)
        addSubview(starView)
        starView.bounds = self.bounds
        starView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setStarWith(rating: Float){
        imdbRating.text = "IMDB Rating = \(rating)"
        if rating == 10.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
        } else if rating >= 9.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star Half Filled-50")
        } else if rating >= 8.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 7.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star Half Filled-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 6.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 5.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star Half Filled-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 4.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 3.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star Half Filled-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 2.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else if rating >= 1.0 {
            starOne.image = #imageLiteral(resourceName: "icons8-Star Filled-50")
            starTwo.image = #imageLiteral(resourceName: "icons8-Star-50")
            starThree.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
            starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
        } else {
            setEmpty()
        }
    }
    
    private func setEmpty(){
        starOne.image = #imageLiteral(resourceName: "icons8-Star-50")
        starTwo.image = #imageLiteral(resourceName: "icons8-Star-50")
        starThree.image = #imageLiteral(resourceName: "icons8-Star-50")
        starFour.image = #imageLiteral(resourceName: "icons8-Star-50")
        starFive.image = #imageLiteral(resourceName: "icons8-Star-50")
    }

}
