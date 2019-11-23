//
//  WeatherViewModel.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import CoreLocation

typealias weatherResult = (WeatherViewModel.outputWeather) -> Void

protocol WeatherViewModelDelegate {
    var weatherOutput: weatherResult? { get set }
    var lat: Double? { get set }
    var long: Double? { get set }
    var days: [String] { get set }
    var results: [WeatherDTO] { get set }
    var city: String? { get }
    func viewDidAppear()
    func viewWillAppear()
    func populateData()
    func getResults() -> (WeatherData, [ForecastWeather])
    
}

class WeatherViewModel : WeatherViewModelDelegate {
    var city: String?
    var results = [WeatherDTO]()
    var lat: Double?
    var long: Double?
    var days = [String]()
    var weatherOutput: weatherResult?
    enum outputWeather {
        case reloadData
        case error(message: String)
    }
    private var service: WeatherServiceDelegate
    init(service: WeatherServiceDelegate) {
        self.service = service
    }
    func viewWillAppear() {
          let location = CLLocation(latitude: lat ?? 0.0, longitude: long ?? 0.0)
                            location.fetchCityAndCountry { [weak self] city, country, error in
                                guard let self = self else { return }
                                guard let city = city, let country = country, error == nil else { return }
                                print(city + ", " + country)  // Rio de Janeiro, Brazil
                                self.city = city
        }
    }
    func viewDidAppear() {
        service.weathers(input: WeatherInput(lat: lat ?? 0.0, long: long ?? 0.0), delegate: self)
    }
    func getResults() -> (WeatherData, [ForecastWeather]) {
        var forecastData = [ForecastWeather]()
        let weatherData = WeatherData(humidity: "\(results[0].main?.humidity ?? 0)%", clouds: "\(results[0].clouds?.all ?? 0)%", wind: "\(results[0].wind?.speed ?? 0)Km/h", temp: String(format: "%.0f", (results[0].main?.temp ?? 0) - 273.15), tempDesc: results[0].weather?[0].weatherDescription?.capitalized ?? "", day: days[0],image: "\(ApiConstants.weatherImageBaseURL)\(results[0].weather?[0].icon ?? "").png" )
        for i in 1...5 {
            forecastData.append(ForecastWeather(image: "\(ApiConstants.weatherImageBaseURL)\(results[i].weather?[0].icon ?? "").png", minmaxTemp: "\(String(format: "%.0f", (results[i].main?.tempMin ?? 0) - 273.15))°\(String(format: "%.0f", (results[i].main?.tempMax ?? 0) - 273.15))°", day: days[i]))
        }
        return (weatherData,forecastData)
    }
    func populateData() {
        weatherOutput?(.reloadData)
       
    }
    public func dayFromdate(date: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = AppConstants.dateFormat
        guard let todayDate = formatter.date(from: date) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.day
        return dateFormatter.string(from: todayDate).capitalized
    }
    public func timeFromDate(date: String) -> String {
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
        results = result.list?.filter({ timeFromDate(date: $0.dtTxt ?? AppConstants.defaultDateValue) == value
        }) ?? []
        results.append(last)
        results.forEach({ (weather) in
            days.append(dayFromdate(date: weather.dtTxt ?? AppConstants.defaultDateValue))
        })
        populateData()
    }
    
    func failure(error: String) {
        print(error)
    }
}
