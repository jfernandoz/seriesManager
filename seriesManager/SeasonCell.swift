//
//  SeasonCell.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell {
    
    weak var delegate: SeasonCellDelegate?

    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBAction func toggleFavorite(_ sender: UIButton) {
        sender.isSelected = (sender.isSelected ? false : true)
        self.delegate?.didClickFavorite(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteBtn.setImage(#imageLiteral(resourceName: "icons8-Star-50"), for: .normal)
        favoriteBtn.setImage(#imageLiteral(resourceName: "icons8-Star Filled-50"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
