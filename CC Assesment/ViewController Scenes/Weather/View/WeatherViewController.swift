//
//  WeatherViewController.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    let locationManager = CLLocationManager()
    var viewModel: WeatherViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
}

extension WeatherViewController : CLLocationManagerDelegate {
    func initLocation() {
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
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
        viewModel?.weatherOutput = { result in
            switch result {
            case .reloadData:
                break
            case .error(let message):
                print(message)
            }
            
        }
    }
}
