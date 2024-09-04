//
//  HomeService.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation
import Alamofire

class HomeRequest: BaseRequest {
    init(dict: [String: Any], type: HomeMovieType) {
        super.init()
        path = type.rawValue
        self.query = queryString(dictionary: dict)
    }
}

class HomeService {
    static let shared = HomeService()
    init() {}
    
    private let jsonDecoder = JSONDecoder()

    func getMovies(request: URLRequestConvertible) async -> Result<MovieResponse, Alamofire.AFError> {
        await withCheckedContinuation { continuation in
            AF.request(request)
                .validate()
                .responseDecodable(of: MovieResponse.self) { response in
                    switch response.result {
                    case .success(let movieResponse):
                        continuation.resume(returning: .success(movieResponse))
                    case .failure(let error):
                        continuation.resume(returning: .failure(error))
                    }
                }
        }
    }
}
