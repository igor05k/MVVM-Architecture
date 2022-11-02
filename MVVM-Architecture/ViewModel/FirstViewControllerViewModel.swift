//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation

protocol FirstVCViewModel {
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
    var showMessage: ((String) -> Void)? { get set }
    
    func getRandomJoke()
}

class FirstViewControllerViewModel: FirstVCViewModel {
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showMessage: ((String) -> Void)?
    
    func getRandomJoke() {
        showLoading?()
        Service.getJoke { [weak self] result in
            self?.hideLoading?()
            switch result {
            case .success(let success):
                self?.showMessage?("\(success.body[0].setup). \(success.body[0].punchline)")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
