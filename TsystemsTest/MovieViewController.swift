//
//  MovieViewController.swift
//  TsystemsTest
//
//  Created by Арина Нефёдова on 19.07.2020.
//  Copyright © 2020 Арина Нефёдова. All rights reserved.
//

import UIKit


class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var vc = ScheduleViewController()
    var movies: [Movie] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MoviesLoader().loadMovies { (movies) in
            self.movies = movies
            self.movieTableView.reloadData()
        }
    }
    @objc func setName(sender:UIButton)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let scheduleViewController = storyboard.instantiateViewController(identifier: "Schedule") as? ScheduleViewController else { return }
        
        let model = movies[sender.tag]
        
        scheduleViewController.movieName = "\(model.original_title)"
        
        
        show(scheduleViewController, sender: nil)
    }
}


extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let model = movies[indexPath.row]
        cell.mTitleLabel.text = "\(model.original_title)"
        
        
        
        if model.release_date.toDate()?.string(with: "MMM dd, yyyy") != nil {
              cell.mDateLabel.text = "\(String(describing: model.release_date.toDate()!.string(with: "MMM dd, yyyy")))"
        } else {
              cell.mDateLabel.text = "\(model.release_date)"
        }
      
        cell.mOverviewLabel.text = "\(model.overview)"
        cell.mRateLabel.text = "\(Int((model.rate * 10).rounded())) %"
        
        cell.sB.tag = indexPath.row
        cell.sB.addTarget(self, action: #selector(self.setName), for: .touchUpInside)
        
    
        if model.poster_path != "" {
        cell.mImageView.downloaded(from: "https://image.tmdb.org/t/p/w220_and_h330_face\(model.poster_path)")
        } else {
            cell.mImageView.image = nil
        }
        return cell
    }
    
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
            self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
