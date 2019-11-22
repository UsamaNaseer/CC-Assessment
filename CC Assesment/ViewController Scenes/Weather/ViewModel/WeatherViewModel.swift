//
//  WeatherViewModel.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

typealias weatherResult = (WeatherViewModel.outputWeather) -> Void

protocol WeatherViewModelDelegate {
    var weatherOutput: weatherResult? { get set }
    var lat: Double? { get set }
    var long: Double? { get set }
    func viewDidAppear()
    func populateData(weathers: [WeatherDTO],days: [String])
}

class WeatherViewModel : WeatherViewModelDelegate {
    var lat: Double?
    var long: Double?
    var days = [String]()
    var weatherOutput: weatherResult?
    enum outputWeather {
        case reloadData(weather: [WeatherDTO],days: [String])
        case error(message: String)
    }
    private var service: WeatherServiceDelegate
    init(service: WeatherServiceDelegate) {
        self.service = service
    }
    func viewDidAppear() {
        service.weathers(input: WeatherInput(lat: lat ?? 0.0, long: long ?? 0.0), delegate: self)
        
    }
    func populateData(weathers: [WeatherDTO],days: [String]) {
        weatherOutput?(.reloadData(weather: weathers,days: days))
    }
    func dayFromdate(date: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = AppConstants.dateFormat
        guard let todayDate = formatter.date(from: date) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.day
        return dateFormatter.string(from: todayDate).capitalized
    }
    func timeFromDate(date: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = AppConstants.dateFormat
        guard let todayDate = formatter.date(from: date) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.timeFormat
        return dateFormatter.string(from: todayDate).capitalized
    }
}

extension WeatherViewModel: WeatherServiceResultDelegate {
    func success(result: WeatherListDTO) {
        guard let last = result.list?[(result.list?.count ?? 1)-1] else { return }
        let value = timeFromDate(date: result.list?[0].dtTxt ?? AppConstants.defaultDateValue)
        var results = result.list?.filter({ timeFromDate(date: $0.dtTxt ?? AppConstants.defaultDateValue) == value
        })
        results?.append(last)
        results?.forEach({ (weather) in
            days.append(dayFromdate(date: weather.dtTxt ?? AppConstants.defaultDateValue))
        })
        populateData(weathers: results ?? [], days: days)
    }
    
    func failure(error: String) {
        print(error)
    }
}
