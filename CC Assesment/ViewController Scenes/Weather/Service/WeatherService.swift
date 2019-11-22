//
//  WeatherService.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

protocol WeatherServiceResultDelegate {
    func success(result: WeatherListDTO)
    func failure(error: String)
}
protocol WeatherServiceDelegate {
    func weathers(input: WeatherInput, delegate: WeatherServiceResultDelegate)
}

class WeatherService: WeatherServiceDelegate {
    func weathers(input: WeatherInput, delegate: WeatherServiceResultDelegate) {
        ApiClient.weatherList(weather: input) { (result) in
            switch result {
            case .success(let resturants):
                delegate.success(result: resturants)
            case .failure(let error):
                delegate.failure(error: error.localizedDescription)
            }
        }
    }

}
