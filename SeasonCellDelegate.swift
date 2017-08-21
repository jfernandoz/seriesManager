//
//  SeasonCellDelegate.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

protocol SeasonCellDelegate: class {
    func didClickFavorite(cell: SeasonCell)
}
