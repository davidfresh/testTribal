//
//  ListJokesPresenter.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation

final class ListJokesPresenter {
    private weak var view: ListJokesContract.View?
    private let jokeUseCase: JokeRandomUseCaseContract
    
    private var viewState: ListJokesViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.render(state: viewState)
        }
    }
    
    private var jokesViewModel =  [JokeViewModel]()
    
    init(view: ListJokesContract.View?,
         jokeUseCase: JokeRandomUseCaseContract) {
        self.view = view
        self.jokeUseCase = jokeUseCase
    }
}



// Presenter
extension ListJokesPresenter: ListJokesContract.Presenter {

    func getListJokes() {
        viewState = .loading
        
        let dispatchGroup = DispatchGroup()
        
        for _ in 1...15 {
            dispatchGroup.enter()
            
            jokeUseCase.getListOfJokeRandom() { [weak self] result in
                defer {
                    dispatchGroup.leave()
                }
                
                switch result {
                case .success(let joke):
                    guard let jokesViewModel = self?.createJokesViewModel(joke: joke) else {
                        return
                    }
                    self?.jokesViewModel.append(jokesViewModel)
                    
                case .failure(let error):
                    var message = error.localizedDescription
                    if let errorUseCase = error as? JokeRandomUseCaseError,
                       let errorDescription = errorUseCase.errorDescription {
                        message = errorDescription
                    }
                    self?.viewState = .error(error: message)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.viewState = .render(joke: self.jokesViewModel)
        }
    }
}

private extension ListJokesPresenter {
    func createJokesViewModel(joke: JokeModel) -> JokeViewModel {
        return JokeViewModel(value: joke.value)
    }
}

