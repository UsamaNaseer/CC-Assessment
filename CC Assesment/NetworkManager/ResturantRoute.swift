//
//  ResturantRoute.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import Alamofire

enum ResturantRoute : URLRequestBuilder {
    case resturants(res: ResturantInput)
}

extension ResturantRoute {
    
    var mainURL: URL  {
        return URL(string: ApiConstants.resturantBaseURL)!
    }
  
    
    var path: String {
        switch self {
        case .resturants:
            return ApiConstants.resturant
        }
    }
    
    var parameters: Parameters? {
        var params = Parameters()
        switch self {
        case .resturants(let resturant):
            params["location"] = resturant.location
            params["radius"] = resturant.radius
            params["type"] = resturant.type
            params["keyword"] = resturant.keyword
            params["key"] = ApiConstants.APIKEY
            return params
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .resturants:
            return .get
        }
    }
    
    
}
