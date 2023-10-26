//
//  JokeRandomUseCase.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation
public protocol JokeRandomUseCaseContract {
    func getListOfJokeRandom(completion: @escaping (Result<JokeModel, Error>) -> Void)
}

public enum JokeRandomUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class JokeRandomUseCase {
    let provider: GetJokeProvaiderContract
    
    public init(provider: GetJokeProvaiderContract) {
        self.provider = provider
    }
}

extension JokeRandomUseCase: JokeRandomUseCaseContract {
    public func getListOfJokeRandom(completion: @escaping (Result<JokeModel, Error>) -> Void) {
        return provider.getJokeRandom() { result in
            switch result {
            case .success(let joke):
                completion(.success(joke))
            case .failure(let error):
                if let providerError = error as? GetJokeProvaiderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(JokeRandomUseCaseError.generic(error: message)))
                }
            }
        }
    }
    
}
