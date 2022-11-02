//
//  Service.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 01/11/22.
//

import Foundation
import Combine

// 670a8a751emsh93bbc953839869ep1ec5efjsn4076d2edbe1a
class Service {
    static func getJoke() -> Future<Joke, Error> {
        return Future { promise in
            guard let url = URL(string: "https://dad-jokes.p.rapidapi.com/random/joke") else { return }
            var request = URLRequest(url: url)
            request.setValue("670a8a751emsh93bbc953839869ep1ec5efjsn4076d2edbe1a", forHTTPHeaderField: "X-RapidAPI-Key")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else { return }
                do {
                    let json = try JSONDecoder().decode(Joke.self, from: data)
                    promise(.success(json))
                    print(json)
                } catch {
                    promise(.failure(error))
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

