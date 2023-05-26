//
//  JsonPlaceHolderService.swift
//  CleanTableView
//
//  Created by Enes Sancar on 25.05.2023.
//

import Foundation
import Alamofire

protocol JsonPlaceHolderProtocol {
    func fetchAllPosts(completion: @escaping([PostModel]) -> Void)
}

enum JsonPlaceHolderPath: String {
    case POSTS = "/posts"
    case COMMENTS = "/comments"
}

extension JsonPlaceHolderPath {
    func withBaseUrl() -> String {
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct JsonPlaceHolderService: JsonPlaceHolderProtocol {
 
    func fetchAllPosts(completion: @escaping ([PostModel]) -> Void) {
        
        AF.request(JsonPlaceHolderPath.POSTS.withBaseUrl(), method: .get).responseData { responseData in
            if let error = responseData.error {
                print(error.localizedDescription)
            }
            guard let data = responseData.data else { return }
            do {
                let response = try JSONDecoder().decode([PostModel].self, from: data)
                completion(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
