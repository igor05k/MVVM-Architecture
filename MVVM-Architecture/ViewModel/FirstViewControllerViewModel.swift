//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation
import Combine

class FirstViewControllerViewModel {
    private var cancellables: Set<AnyCancellable> = []
    var showLoading = PassthroughSubject<Any, Never>()
    var hideLoading = PassthroughSubject<Any, Never>()
    @Published var showMessage: String?
    
    func getRandomJoke() {
        hideLoading.send(completion: .finished)
        Service.getJoke().receive(on: DispatchQueue.main).sink { [weak self] completion in
            switch completion {
            case .finished:
                print("Finished")
                self?.showLoading.send(completion: .finished)
            case .failure(let error):
                print("error: ", error)
            }
        } receiveValue: { value in
            self.showMessage = "\(value.body[0].setup) \(value.body[0].punchline)"
        }.store(in: &cancellables)
    }
}
