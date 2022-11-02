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
    
    private var viewModel: FirstVCViewModel
    
    required init?(coder: NSCoder) {
        viewModel = FirstViewControllerViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLbl.text = "Joke"
        jokeButton.configuration?.title = "Get Joke"
        setupBinding()
    }
    
    func setupBinding() {
        viewModel.showLoading = { [weak self] in
            self?.jokeButton.configuration?.showsActivityIndicator = true
            self?.jokeButton.configuration?.title = nil
            self?.jokeButton.isEnabled = false
        }
        
        viewModel.hideLoading = { [weak self] in
            self?.jokeButton.configuration?.showsActivityIndicator = false
            self?.jokeButton.configuration?.title = "Get joke"
            self?.jokeButton.isEnabled = true
        }
        
        viewModel.showMessage = { message in
            self.jokeLbl.text = message
        }
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
        viewModel.getRandomJoke()
    }
}

