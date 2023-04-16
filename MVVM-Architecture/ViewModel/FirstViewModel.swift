//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift

class FirstViewModel {
    
    private(set) var isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    private(set) var joke = BehaviorRelay<Joke?>(value: nil)

    func getRandomJoke() {
        let request = Service.getJoke()
        isLoading.accept(true)
        request.subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let data):
                self?.joke.accept(data)
                self?.isLoading.accept(false)
            case .failure(let error):
                print("error==========", error)
            }
        }).disposed(by: disposeBag)
    }
    
//    func getRandomJoke() {
//        showLoading?()
//        Service.getJoke { [weak self] result in
//            self?.hideLoading?()
//            switch result {
//            case .success(let success):
//                self?.showMessage?("\(success.body[0].setup). \(success.body[0].punchline)")
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
}
