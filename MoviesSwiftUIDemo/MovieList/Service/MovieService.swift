//
//  MovieService.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import Foundation
import Alamofire

class MovieRequest: BaseRequest {
    init(dict: [String: Any], id: Int) {
        super.init()
        path = "movie/\(id)"
        self.query = queryString(dictionary: dict)
    }
}

class MovieService {
    static let shared = MovieService()
    init() {}
    
    private let jsonDecoder = JSONDecoder()

    func getMovieDetail(request: URLRequestConvertible) async -> Result<MovieDetailResponse, Alamofire.AFError> {
        await withCheckedContinuation { continuation in
            AF.request(request)
                .validate()
                .responseDecodable(of: MovieDetailResponse.self) { response in
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
