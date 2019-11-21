//
//  ResturantViewModel.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

typealias output = (ResturantViewModel.OutputType) -> Void

protocol ResturantViewModelDelegate {
    var numberOfRows: Int { get }
    var results: [Resturant] { get }
    func viewDidLoad()
    var output: output? { get set }
    func populateData()
    func getCellViewModel(indexpath: IndexPath) -> ResturantCellViewModel
}

class ResturantViewModel: ResturantViewModelDelegate {
        enum OutputType {
        case reloadData
        case error(message: String)
        }
    var output: output?
        var results = [Resturant]()
        var cellViewModels = [ResturantCellViewModel]()
        var numberOfRows: Int {
            return cellViewModels.count
        }
        private var service: ResturantServiceDelegate
        init(service: ResturantServiceDelegate) {
         self.service = service
        }
        func viewDidLoad() {
            service.resturants(input: ResturantInput(location: "-33.8670522,151.1957362", radius: 1000, type: "resturant", keyword: "food"), delegate: self)
        }
        func getCellViewModel(indexpath: IndexPath) -> ResturantCellViewModel {
            let cellModel = cellViewModels[indexpath.row]
            return cellModel
        }
        func populateData() {
            output?(.reloadData)
        }
}

extension ResturantViewModel: ResturantServiceResultDelegate {
    func success(result: ResturantDTO) {
        result.results?.forEach({ (resturant) in
            cellViewModels.append(ResturantCellViewModel.init(model: resturant))
        })
        populateData()
    }
    
    func failure(error: String) {
        print(error)
    }
}
