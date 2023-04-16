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
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRandomJoke()
        setActivityIndicator()
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        viewModel = FirstViewModel()
        super.init(coder: coder)
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
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
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] joke in
                self?.jokeLbl.text = "\(joke?.body[0].setup ?? ""). \(joke?.body[0].punchline ?? "")"
                self?.enableButton()
            }).disposed(by: disposeBag)
        
        viewModel.isLoading
            .take(2) // limita a qtd de eventos ouvidos para 2 (true e false); assim, o indicator só é mostrado 1 vez.
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.hideElements()
                    self?.animateLoading()
                } else {
                    self?.showElements()
                    self?.stopLoading()
                }
                
            }).disposed(by: disposeBag)
    }
    
    func animateLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func hideElements() {
        jokeLbl.isHidden = true
        jokeButton.isHidden = true
    }
    
    func showElements() {
        jokeLbl.isHidden = false
        jokeButton.isHidden = false
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

