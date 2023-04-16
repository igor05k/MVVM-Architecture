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
    
    private var viewModel: FirstViewModel
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        viewModel = FirstViewModel()
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
        
        viewModel.joke
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] joke in
                self?.jokeLbl.text = "\(joke?.body[0].setup ?? ""). \(joke?.body[0].punchline ?? "")"
                self?.enableButton()
            }).disposed(by: disposeBag)
    }
    
    func disableButton() {
        jokeButton.configuration?.showsActivityIndicator = true
        jokeButton.configuration?.title = nil
        jokeButton.isEnabled = false
    }
    
    func enableButton() {
        jokeButton.configuration?.showsActivityIndicator = false
        jokeButton.configuration?.title = "Get Joke"
        jokeButton.isEnabled = true
    }
}

