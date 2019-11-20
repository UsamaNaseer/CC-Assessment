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
    case resturants
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
        let params = Parameters()
        switch self {
        case .resturants:
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
