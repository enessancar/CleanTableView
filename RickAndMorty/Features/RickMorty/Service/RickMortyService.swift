//
//  RickMortyService.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 25.05.2023.
//

import Foundation
import Alamofire

enum RickMortyServiceEndpoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol RickyMortyService{
    func fetchAllData(completion: @escaping([Result]?) -> Void)
}

struct RickMortyService: RickyMortyService {
    
    func fetchAllData(completion: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndpoint.characterPath(), method: .get)
            .responseData { response in
                if let error = response.error {
                    print(error.localizedDescription)
                }
                guard let data = response.data else { return }
                do {
                    let result = try JSONDecoder().decode(PostModel.self, from: data)
                    completion(result.results)
                }catch {
                    print(error.localizedDescription)
                }
            }
    }
}
