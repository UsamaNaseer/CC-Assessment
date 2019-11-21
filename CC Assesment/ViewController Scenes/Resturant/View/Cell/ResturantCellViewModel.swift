//
//  ResturantCellViewModel.swift
//  CC Assesment
//
//  Created by Usama Naseer on 22/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

struct ResturantCellViewModel {
    var name : String
    var location: String
    var rating: Double
    var reviews: String
    var image: String
    init() {
                name = ""
               location = ""
               rating =  0.0
               reviews = "0 reviews"
               image = ""
    }
    init(model: Resturant) {
        name = model.name ?? ""
        location = model.vicinity ?? ""
        rating = model.rating ?? 0.0
        reviews = "\(model.userRatingsTotal ?? 0) reviews"
        image = "\(ApiConstants.imageBaseURL)maxheight=\(model.photos?[0].height ?? 0)&maxwidth=\(model.photos?[0].width ?? 0)&photoreference=\(model.photos?[0].photoReference ?? "")&key=\(ApiConstants.APIKEY)"
        
    }
    
    private func starsCount(number: Double) -> [String] {
        var array = [String]()
        var rounded = round(number)
        var num = 5 - rounded
        while rounded > 0 {
            array.append("star.fill")
            rounded = rounded - 1
        }
        while num > 0 {
            array.append("star")
            num = num - 1
        }
        return array
    }
    
}
