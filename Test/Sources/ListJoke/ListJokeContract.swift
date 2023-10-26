//
//  ListJokesContract.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation
enum ListJokesContract {
    typealias Presenter = ListJokesPresenterContract
    typealias View = ListJokesViewContract
    typealias Navigator = ListJokesNavigatorContract
}

protocol ListJokesPresenterContract {
    func getListJokes()
}

protocol ListJokesViewContract: AnyObject {
    func render(state: ListJokesViewState)
}

protocol ListJokesNavigatorContract {
 // Logica de navegacion
}

enum ListJokesViewState: Equatable {
    case clear
    case loading
    case render(joke: [JokeViewModel])
    case error(error: String)
}
