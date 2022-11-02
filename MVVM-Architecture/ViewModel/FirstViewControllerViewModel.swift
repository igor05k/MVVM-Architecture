//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation

protocol FirstVCViewModelDelegate: AnyObject {
    func showLoading()
    func hideLoading()
    func showMessage(_ message: String)
}

class FirstViewControllerViewModel {
    
    weak var delegate: FirstVCViewModelDelegate?
    
    func getRandomJoke() {
        delegate?.showLoading()
        Service.getJoke { [weak self] result in
            self?.delegate?.hideLoading()
            switch result {
            case .success(let success):
                self?.delegate?.showMessage("\(success.body[0].setup). \(success.body[0].punchline)")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
