//
//  Joke.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation

struct Joke: Codable {
    let body: [Body]
}

struct Body: Codable {
    let setup, punchline: String
}
