//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation
import Combine

class FirstViewControllerViewModel {
    // var showLoading: (() -> Void)?
    // func showLoading()
    private var cancellables: Set<AnyCancellable> = []
    var showLoading = PassthroughSubject<Void, Never>()
    var hideLoading = PassthroughSubject<Void, Never>()
    @Published var showMessage: String?
    
    func getRandomJoke() {
        showLoading.send()
        Service.getJoke().receive(on: DispatchQueue.main).sink { [weak self] completion in
            switch completion {
            case .finished:
                print("Finished")
                self?.hideLoading.send()
            case .failure(let error):
                print("error: ", error)
            }
        } receiveValue: { value in
            self.showMessage = "\(value.body[0].setup) \(value.body[0].punchline)"
        }.store(in: &cancellables)
    }
}
