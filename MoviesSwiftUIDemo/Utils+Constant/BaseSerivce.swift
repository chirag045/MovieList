//
//  BaseSerivce.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation
import Alamofire

class BaseRequest: URLRequestConvertible {
    var path: String = ""
    var query: String = ""
    var method: HTTPMethod = .get
    var parameters: Codable?
    
    let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzBlN2E4NjhmNzgwMWUxMzEwMjQ2ZTBiNDY5OTI2NyIsIm5iZiI6MTcyNTI4ODMxOC4wNTk4OTksInN1YiI6IjY2ZDVjZTM0NTMyZjZhMDhhZTk0OTRjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.a_yI4uWs4bxM71MRluv4axMJTJFTd3pe_HrnBO-2vUw"
    ]
    
    func asURLRequest() throws -> URLRequest {
        let endpoint = Constants.baseAPIURL + path + query
        
        guard let url = URL(string: endpoint)
        else {
            throw AFError.invalidURL(url: endpoint)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        if let parameters = parameters {
            do {
                let body = try JSONEncoder().encode(parameters)
                urlRequest.httpBody = body
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
