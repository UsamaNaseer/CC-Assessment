//
//  ResturantViewController.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit
import CoreLocation

class ResturantViewController: UIViewController {
    let locationManager = CLLocationManager()
    var viewModel: ResturantViewModelDelegate?
    @IBOutlet weak var resturantTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    func bindViewModel() {
        viewModel?.output = { [weak self] output in
            guard let self = self else { return }
            switch output {
            case .reloadData:
                self.resturantTableView.reloadData()
            case .error(let message):
                print(message)
            }
            
        }
    }
}

extension ResturantViewController {
    func initViews() {
        viewModel?.viewDidLoad()
        setNavigation()
        bindViewModel()
        initLocation()
    }
}
extension ResturantViewController : CLLocationManagerDelegate {
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
        viewModel?.location = "\(locValue.latitude),\(locValue.longitude)"
    }
    func setNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "Blue")
        navigationController?.navigationBar.tintColor = .white
    }
}
extension ResturantViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel?.getCellViewModel(indexpath: indexPath) ?? ResturantCellViewModel()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resturantCell") as? ResturantTableViewCell else { let cell = ResturantTableViewCell(style: .default, reuseIdentifier: "resturantCell")
            return cell
        }
        cell.updateCell(model: cellModel)
        cell.selectionStyle = .none
        return cell
    }
}
