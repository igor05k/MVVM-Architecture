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
    
    private let isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    private(set) var joke = BehaviorRelay<Joke?>(value: nil)

    func getRandomJoke() {
        let request = Service.getJoke()
        request.subscribe(onNext: { result in
            switch result {
            case .success(let data):
                self.joke.accept(data)
            case .failure(let error):
                print("error==========", error)
            }
        }).disposed(by: disposeBag)
    }
}
