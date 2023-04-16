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

protocol FirstVCViewModel {
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
    var showMessage: ((String) -> Void)? { get set }
    
    func getRandomJoke()
}

class FirstViewControllerViewModel: FirstVCViewModel {
    
    private let isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showMessage: ((String) -> Void)?
    
    func getRandomJoke() {
        let request = Service.getJoke()
        
        request.subscribe(onNext: { result in
            switch result {
            case .success(let data):
                print("data===========", data)
            case .failure(let error):
                print("error==========", error)
            }
        }).disposed(by: disposeBag)
    }
}
