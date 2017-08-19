//
//  ViewController.swift
//  seriesManager
//
//  Created by MCS on 8/18/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let api = APIManager()
        api.delegate = self
        api.getShow(withSeriesName: "Game of Thrones")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: APIDelegate{

    func didReturnShow(show: ShowModel){
        print(show.title ?? "No show")
    }
}
