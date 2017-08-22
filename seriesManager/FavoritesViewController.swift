//
//  FavoritesViewController.swift
//  seriesManager
//
//  Created by MCS on 8/21/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
//
//    var show = ShowModel()
//    var seasons = [SeasonModel]()
    var episodes = [EpisodeModel]()
    var episode = EpisodeModel()
    var episodePersistence = [String]()
    let api = APIManager()
    let dp = DataPersistenceManager()
    
    let seriesName = "Game of Thrones"

    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        episodes.removeAll()
        episodePersistence = dp.getEpisodes()
        if(episodePersistence.count == 0){
            tableView.reloadData()
        }else{
            for item in episodePersistence {
                api.getEpisode(withId: item)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        cell.episodeLbl.text = episodes[indexPath.row].title
        cell.favoriteVal.isSelected = true
        cell.delegate = self
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorites"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        episode = episodes [indexPath.row]
        performSegue(withIdentifier: "viewDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetail" {
            guard let detailView = segue.destination as? DetailViewController else {
                return
            }
            detailView.episode = episode
        }
    }

}

//MARK: API Delegate Functions

extension FavoritesViewController: APIDelegate {
    func didReturnShow(show: ShowModel) {
    }
    
    func didReturnSeason(season: SeasonModel) {
    }
    
    func didReturnEpisode(episode: EpisodeModel) {
        episodes.append(episode)
        if(episodes.count == episodePersistence.count){
            tableView.reloadData()
        }
    }
    
}

//MARK: FavoriteCell Delegate Functions

extension FavoritesViewController: FavoriteCellDelegate {
    func didClickFavorite(cell: FavoriteCell) {
        guard let index = tableView.indexPath(for: cell) else {
            return
        }
        guard let episode = episodes[index.row].episodeId else {
            return
        }
        dp.delete(episodeId: episode)
        episodes.remove(at: index.row)
        tableView.reloadData()
    }
}


