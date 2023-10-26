//
//  GetJokeProvaider.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation

public class GetJokeProvaider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension GetJokeProvaider: GetJokeProvaiderContract {
    public func getJokeRandom(completion: @escaping (Result<JokeModel, Error>) -> Void) {
        apiClient.execute(endpoint: .getRandomJoke) { (response: WebServiceResponse<JokeEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain() else {
                      if case .failure(let error) = response,
                         let webError = error as? WebServiceProtocolError,
                         let message = webError.errorDescription {
                          completion(.failure(GetJokeProvaiderContractError.generic(error: message)))
                      }
                      return
                  }
            completion(.success(model))
        }
   }
}
