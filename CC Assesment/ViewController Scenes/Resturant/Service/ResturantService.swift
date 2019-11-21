//
//  ResturantService.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

protocol ResturantServiceResultDelegate {
    func success(result: ResturantDTO)
    func failure(error: String)
}
protocol ResturantServiceDelegate {
    func resturants(input: ResturantInput, delegate: ResturantServiceResultDelegate)
}

class ResturantService: ResturantServiceDelegate {
    func resturants(input: ResturantInput, delegate: ResturantServiceResultDelegate) {
        ApiClient.resturants(res: input) { (result) in
            switch result {
            case .success(let resturants):
                delegate.success(result: resturants)
            case .failure(let error):
                delegate.failure(error: error.localizedDescription)
            }
        }
    }

}
