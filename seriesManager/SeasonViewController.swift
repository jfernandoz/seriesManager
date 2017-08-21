//
//  SeasonViewController.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class SeasonViewController: UITableViewController {
    
    var show = ShowModel()
    var seasons = [SeasonModel]()
    var episode = EpisodeModel()
    var episodePersistence = [String]()
    let api = APIManager()
    let dp = DataPersistenceManager()
 
    let seriesName = "Game of Thrones"

    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.getShow(withSeriesName: seriesName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        episodePersistence = dp.getEpisodes()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSeasons = show.totalSeasons else {
            return 0
        }
        return numberOfSeasons
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfEpisodes = seasons[section+1].episodes?.count else {
            return 0
        }
        return numberOfEpisodes
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episode = seasons[indexPath.section+1].episodes?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as! SeasonCell
        cell.episodeLbl.text = episode[APISettings.titleKey]
        cell.delegate = self
        if let episodeId = episode[APISettings.id], episodePersistence.contains(episodeId) {
            cell.favoriteBtn.isSelected = true
        } else {
            cell.favoriteBtn.isSelected = false
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section+1)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        api.getEpisode(withSeriesName: seriesName, seasonNumber: indexPath.section+1, episodeNumber: indexPath.row + 1)
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

extension SeasonViewController: APIDelegate {
    
    func didReturnShow(show: ShowModel) {
        self.show = show
        guard let seasonMax = show.totalSeasons else {
            return
        }
        for seasonNumber in 0...seasonMax {
            api.getSeason(withSeriesName: seriesName, seasonNumber: seasonNumber)
        }
        
    }
    
    func didReturnSeason(season: SeasonModel) {
        self.seasons.append(season)
        if season.season == show.totalSeasons {
            tableView.reloadData()
        }
    }
    
    func didReturnEpisode(episode: EpisodeModel) {
        self.episode = episode
        performSegue(withIdentifier: "viewDetail", sender: self)
    }
    
}

//MARK: SeasonCell Delegate Favorites

extension SeasonViewController: SeasonCellDelegate {
    func didClickFavorite(cell: SeasonCell) {
        guard let index = tableView.indexPath(for: cell) else {
            return
        }
        guard let episode = seasons[index.section + 1].episodes?[index.row][APISettings.id] else {
            return
        }
        if cell.favoriteBtn.isSelected {
            dp.save(episodeId: episode)
        }else{
            dp.delete(episodeId: episode)
        }
    
    }
}
