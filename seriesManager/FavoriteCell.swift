//
//  FavoriteCell.swift
//  seriesManager
//
//  Created by MCS on 8/21/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    weak var delegate:FavoriteCellDelegate?

    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var favoriteVal: UIButton!
    @IBAction func toggleFavorite(_ sender: UIButton) {
        self.delegate?.didClickFavorite(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteVal.setImage(#imageLiteral(resourceName: "icons8-Star-50"), for: .normal)
        favoriteVal.setImage(#imageLiteral(resourceName: "icons8-Star Filled-50"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
