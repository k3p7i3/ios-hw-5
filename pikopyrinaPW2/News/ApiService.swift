//
//  ApiService.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 08.12.2022.
//

import Foundation

final class ApiService {
    // shared is a object to implement singleton pattern for ApiService class
    static let shared = ApiService()
    
    private let apiKey: String = "b9ecbf7a4715487499fd51fdef8680ec"
    
    // a country to get topic news from
    private let country: String = "us"
    
    private init(){}
    
    func getTopStories(completionHandler: @escaping (Result<[News], Error>) -> Void){
        let request: String = "https://newsapi.org/v2/top-headlines?country=" + country + "&apiKey=" + apiKey
        guard let url =  URL(
            string: request
        ) else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }
    
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if
                let data = data,
                let result = try? JSONDecoder().decode(NewsArray.self, from: data)
            {
                completionHandler(.success(result.articles))
            } else {
                guard let error = error else { return }
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct NewsArray: Decodable {
    var articles: [News]
}

struct News: Decodable {
    var title: String
    var description: String?
    var urlToImage: String?
}
