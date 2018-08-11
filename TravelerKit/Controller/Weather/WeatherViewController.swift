//
//  WeatherViewController.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 11/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    //LocalWeatherView
    @IBOutlet weak var localCityName: UILabel!
    @IBOutlet weak var localWeatherDescription: UILabel!
    @IBOutlet weak var localWeatherIcon: UIImageView!
    @IBOutlet weak var localTemp: UILabel!
    @IBOutlet weak var localDay: UILabel!
    @IBOutlet weak var localHighTemp: UILabel!
    @IBOutlet weak var localLowTemp: UILabel!

    //DestinationWeatherView
    @IBOutlet weak var destinationCityName: UILabel!
    @IBOutlet weak var destinationWeatherDescription: UILabel!
    @IBOutlet weak var destinationWeatherIcon: UIImageView!
    @IBOutlet weak var destinationTemp: UILabel!
    @IBOutlet weak var destinationDay: UILabel!
    @IBOutlet weak var destinationHighTemp: UILabel!
    @IBOutlet weak var destinationLowTemp: UILabel!

}

// MARK: - Methodes
extension WeatherViewController {
    override func viewDidLoad() {

        //Observe notification
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertError(_:)), name: .errorWeather, object: nil)
    }

    ///Displays errors
    @objc private func showAlertError(_ notification: Notification) {
        guard let message = notification.userInfo?["error"] as? String else { return }

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
