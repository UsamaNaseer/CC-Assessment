//
//  RequestBuilder.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder : URLRequestConvertible {
    var mainURL : URL { get }
       var requestURL : URL { get }
       var path : String { get }
       var headers : HTTPHeaders { get }
       var parameters : Parameters? { get }
       var urlRequest : URLRequest { get }
       var encoding : ParameterEncoding { get }
       var method : HTTPMethod { get }
}

extension URLRequestBuilder {
        var headers : HTTPHeaders {
            let header = HTTPHeaders()
            return header
        }
        var requestURL: URL {
            return mainURL.appendingPathComponent(path)
        }
        var encoding: ParameterEncoding {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }
        var urlRequest : URLRequest {
            var request = URLRequest(url: requestURL)
            request.httpMethod = method.rawValue
           // headers.forEach( request.addValue($1, forHTTPHeaderField: $0) )
            return request
        }
        func asURLRequest() throws -> URLRequest {
            return try encoding.encode(urlRequest, with: parameters)
        }
}
