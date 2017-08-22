//
//  DetailViewController.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var plotView: UITextView!
    @IBOutlet weak var progressView: UIProgressView!

    var episode = EpisodeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let episodeTitle = episode.title, let season = episode.season, let episodeNum = episode.episode {
            titleLbl.text = "\(episodeTitle) S\(season) E\(episodeNum)"
        }
        if let release = episode.released {
            let df = DateFormatter()
            df.dateFormat = APISettings.dateAPIFormat
            releaseLbl.text = "Released: \(df.string(from: release))"
        }
        if let episodePlot = episode.plot {
            plotView.text = episodePlot
        }
        progressView.isHidden = false
        progressView.progress = 0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let imageURL = episode.poster {
            URLSession.downloadWith(urlString: imageURL, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

//MARK: Session Delegate
extension DetailViewController: URLSessionDownloadDelegate{
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        let data = try? Data.init(contentsOf: location)
        DispatchQueue.main.async {
            self.image.image = UIImage.init(data: data!)
            self.progressView.isHidden = true
        }
    }

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.progressView.progress = Float(totalBytesWritten/totalBytesExpectedToWrite)
        }
    }
}
