//
//  ViewController.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 01/11/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLbl: UILabel!
    @IBOutlet weak var jokeButton: UIButton!
    
    private var viewModel = FirstViewControllerViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLbl.text = "Joke"
        jokeButton.configuration?.title = "Get Joke"
        setupBind()
    }
    
    func setupBind() {
        viewModel.loading.sink { [weak self] action in
            switch action {
            case .show:
                self?.jokeButton.configuration?.showsActivityIndicator = true
                self?.jokeButton.configuration?.title = nil
                self?.jokeButton.isEnabled = false
            case .hide:
                self?.jokeButton.configuration?.showsActivityIndicator = false
                self?.jokeButton.configuration?.title = "Get Joke"
                self?.jokeButton.isEnabled = true
            }
        }.store(in: &cancellables)
        
        viewModel.$showMessage.sink { [weak self] message in
            self?.jokeLbl.text = message
        }.store(in: &cancellables)
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
        viewModel.getRandomJoke()
    }
}

