//
//  WeatherRequest.swift
//  CC AssesmentTests
//
//  Created by Usama Naseer on 23/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import XCTest
@testable import CC_Assesment

class WeatherViewModelTest: XCTestCase {
       func testDayCheck() {
        let viewModel = WeatherViewModel(service: WeatherService())
        let day = viewModel.dayFromdate(date: "2019-11-24 11:00:00")
        XCTAssert(day == "Sunday")
     }
      func testTimeCheck() {
       let viewModel = WeatherViewModel(service: WeatherService())
       let time = viewModel.timeFromDate(date: "2019-11-24 11:00:00")
       XCTAssert(time == "11:00:00")
    }


}
