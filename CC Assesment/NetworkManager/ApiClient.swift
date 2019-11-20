//
//  ApiClient.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    @discardableResult
    private static func performRequest<T:Decodable> (builder: URLRequestBuilder,decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T,AFError>)->Void) -> DataRequest {
    return AF.request(builder)
    .responseDecodable(decoder: decoder){ (response: DataResponse<T,AFError>) in
        completion(response.result)
    }
    }
}
