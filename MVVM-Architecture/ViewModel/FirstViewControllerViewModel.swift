//
//  FirstViewControllerViewModel.swift
//  MVVM-Architecture
//
//  Created by Igor Fernandes on 02/11/22.
//

import Foundation
import Combine

enum Action {
    case show
    case hide
}

class FirstViewControllerViewModel {
    private var cancellables: Set<AnyCancellable> = []
    var loading = PassthroughSubject<Action, Never>()
    @Published var showMessage: String?
    
    func getRandomJoke() {
        loading.send(.show)
        Service.getJoke().receive(on: DispatchQueue.main).sink { [weak self] completion in
            switch completion {
            case .finished:
                print("Finished")
                self?.loading.send(.hide)
            case .failure(let error):
                print("error: ", error)
            }
        } receiveValue: { value in
            self.showMessage = "\(value.body[0].setup) \(value.body[0].punchline)"
        }.store(in: &cancellables)
    }
}
