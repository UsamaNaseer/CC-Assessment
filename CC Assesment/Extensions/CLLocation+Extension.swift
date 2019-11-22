//
//  CLLocation+Extension.swift
//  CC Assesment
//
//  Created by Usama Naseer on 23/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit
import MapKit


extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
