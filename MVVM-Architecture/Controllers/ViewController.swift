//
//  ViewController.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 01/11/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLbl: UILabel!
    @IBOutlet weak var jokeButton: UIButton!
    
    private var viewModel: FirstVCViewModel
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        viewModel = FirstViewControllerViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVisualElements()
        bindRx()
    }
    
    func setupVisualElements() {
        jokeLbl.text = "Joke"
        jokeButton.configuration?.title = "Get Joke"
    }
    
    func bindRx() {
        jokeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.getRandomJoke()
            self?.disableButton()
        }).disposed(by: disposeBag)
    }
    
    func disableButton() {
        jokeButton.configuration?.showsActivityIndicator = true
        jokeButton.configuration?.title = nil
        jokeButton.isEnabled = false
    }
}

