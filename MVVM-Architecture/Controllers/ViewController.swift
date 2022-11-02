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
    
    private var viewModel = FirstViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLbl.text = "Joke"
        jokeButton.configuration?.title = "Get Joke"
        viewModel.delegate = self
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
        viewModel.getRandomJoke()
    }
}

extension ViewController: FirstVCViewModelDelegate {
    func showLoading() {
        jokeButton.configuration?.showsActivityIndicator = true
        jokeButton.configuration?.title = nil
        jokeButton.isEnabled = false
    }
    
    func hideLoading() {
        jokeButton.configuration?.showsActivityIndicator = false
        jokeButton.configuration?.title = "Get Joke"
        jokeButton.isEnabled = true
    }
    
    func showMessage(_ message: String) {
        jokeLbl.text = message
    }
}
