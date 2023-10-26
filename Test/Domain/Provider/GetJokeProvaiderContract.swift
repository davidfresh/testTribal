//
//  GetJokeProvaiderContract.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation
public enum GetJokeProvaiderContractError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public protocol GetJokeProvaiderContract {
    func getJokeRandom(completion: @escaping (Result<JokeModel, Error>) -> Void)
}
