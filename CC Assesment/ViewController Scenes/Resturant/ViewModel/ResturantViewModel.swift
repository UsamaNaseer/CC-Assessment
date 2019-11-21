//
//  ResturantViewModel.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

protocol ResturantViewModelDelegate {
     func viewDidLoad()
}

class ResturantViewModel: ResturantViewModelDelegate {
        private var service: ResturantServiceDelegate
        init(service: ResturantServiceDelegate) {
         self.service = service
        }
    func viewDidLoad() {
        service.resturants(input: ResturantInput(location: "-33.8670522,151.1957362", radius: 1000, type: "resturant", keyword: "food"), delegate: self)
    }
    
}

extension ResturantViewModel: ResturantServiceResultDelegate {
    func success(result: ResturantDTO) {
        print(result)
    }
    
    func failure(error: String) {
        print(error)
    }
}
