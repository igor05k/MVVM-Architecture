//
//  Service.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 01/11/22.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidUrl
}

class Service {
    static func getJoke() -> Observable<Result<Joke, Error>> {
        guard let url = URL(string: "https://dad-jokes.p.rapidapi.com/random/joke") else { return Observable.error(APIError.invalidUrl) }
        var request = URLRequest(url: url)
        request.setValue("670a8a751emsh93bbc953839869ep1ec5efjsn4076d2edbe1a", forHTTPHeaderField: "X-RapidAPI-Key")
        
        return URLSession.shared.rx.data(request: request).map { data -> Result<Joke, Error> in
            do {
                let json = try JSONDecoder().decode(Joke.self, from: data)
                return .success(json)
            } catch {
                return .failure(error)
            }
        }.asObservable()
    }
}

