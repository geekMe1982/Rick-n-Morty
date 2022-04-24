//
//  NetworkManager.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 23.04.2022.
//

import Foundation

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

fileprivate struct APIResponse: Codable {
    let results: [Character]
    let info: Information
}

class NetworkManager {

    static var shared = NetworkManager()

    let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    private func components() -> URLComponents {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "rickandmortyapi.com"
        return comp
    }

    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("", forHTTPHeaderField: "Authorization")
        return request
    }

    func getCharacters(query: String, completion: @escaping ([Character]?, Error?) -> (Void)) {

        var comp = components()
        comp.path = "/api/character"
//        comp.queryItems = [
//            URLQueryItem(name: "", value: query)
//        ]
        let req = request(url: comp.url!)

        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }

            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }

            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(response.results, nil)
                print(response.info.pages)


            } catch let error {
                completion(nil, error)
            }
        }

        task.resume()
    }
}
