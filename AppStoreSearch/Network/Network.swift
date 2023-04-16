//
//  Network.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import Foundation
import Alamofire

final class Network {
    static let `default` = Network()
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 15
    }
    
    public func AppstoreSearch(_ url: String, _ completionHandler: @escaping (SearchData?, Int?, Error?) -> Void) {
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let url = URL(string: encoded) else { return }
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default
        )
        .validate(statusCode: 200...400)
        .responseDecodable(of: SearchData.self) { response in
            switch response.result {
                
            case .success(let success):
                completionHandler(success, response.response?.statusCode, nil)
            case .failure(let error):
                completionHandler(nil, response.response?.statusCode, error)
                print(error)
            }
        }
    }
}
