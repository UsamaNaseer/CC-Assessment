//
//  ResturantBuilder.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import UIKit

protocol ResturantBuilderDelegate {
    func build() -> ResturantViewController?
}

class ResturantBuilder: ResturantBuilderDelegate {
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    func build() -> ResturantViewController? {
        guard let resturant = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ResturantViewController") as? ResturantViewController else { return nil }
        resturant.viewModel = ResturantViewModel(service: ResturantService())
        return resturant
    }
}
