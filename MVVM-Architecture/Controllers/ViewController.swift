//
//  ViewController.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 01/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLbl: UILabel!
    @IBOutlet weak var jokeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLbl.text = "Joke"
        jokeButton.configuration?.title = "Get Joke"
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
        jokeButton.configuration?.showsActivityIndicator = true
        jokeButton.configuration?.title = nil
        jokeButton.isEnabled = false
        
        Service.getJoke { [weak self] result in
            self?.jokeButton.configuration?.showsActivityIndicator = false
            self?.jokeButton.configuration?.title = "Get Joke"
            self?.jokeButton.isEnabled = true
            
            switch result {
            case .success(let success):
                self?.jokeLbl.text = "\(success.body[0].setup). \(success.body[0].punchline)"
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

