//
//  WeatherViewController.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage

class WeatherViewController: UIViewController {
    let locationManager = CLLocationManager()
    var viewModel: WeatherViewModelDelegate?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var forecastImage: [UIImageView]!
    @IBOutlet var forecastMinMaxTemp_lb: [UILabel]!
    @IBOutlet var forecastDays_lb: [UILabel]!
    @IBOutlet weak var wind_lb: UILabel!
    @IBOutlet weak var humidity_lb: UILabel!
    @IBOutlet weak var clouds_lb: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temp_lb: UILabel!
    @IBOutlet weak var weatherDesc_lb: UILabel!
    @IBOutlet weak var day_lb: UILabel!
    @IBOutlet weak var city_lb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        viewModel?.viewDidAppear()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    @IBAction func popularResturantTapped(_ sender: Any) {
        guard let resturant = ResturantBuilder().build() else { return }
        navigationController?.pushViewController(resturant, animated: true)
    }
}

extension WeatherViewController : CLLocationManagerDelegate {
    func initLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel?.lat = locValue.latitude
        viewModel?.long = locValue.longitude
    }
}

extension WeatherViewController {
    func initViews(){
        viewModel = WeatherViewModel(service: WeatherService())
        initLocation()
        setHeight()
        viewModel?.weatherOutput = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .reloadData:
                self.updateUi()
            case .error(let message):
                print(message)
            }
            
        }
    }
    func setHeight() {
        heightConstraint.constant = UIScreen.main.bounds.height * 0.75
    }
    func updateUi(){
        guard let results = viewModel?.getResults() else { return }
        let weather = results.0
        let forecast = results.1
        humidity_lb.text = weather.humidity
        clouds_lb.text = weather.clouds
        day_lb.text = weather.day
        wind_lb.text = weather.wind
        temp_lb.text = weather.temp
        weatherDesc_lb.text = weather.tempDesc
        weatherImage.sd_setImage(with: URL(string: weather.image), placeholderImage: UIImage(named: "placeholder.png"))
        for i in 0...4 {
            forecastDays_lb[i].text = forecast[i].day
            forecastMinMaxTemp_lb[i].text = forecast[i].minmaxTemp
            forecastImage[i].sd_setImage(with: URL(string: forecast[i].image), placeholderImage: UIImage(named: "placeholder.png"))
        }
        city_lb.text = viewModel?.city ?? "Karachi"
    }
}
