//
//  APIDelegate.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

protocol APIDelegate: class {
    func didReturnShow(show: ShowModel)
}
