//
//  APIClient.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation

final class APIClient: WebServiceProtocol {
    func execute<Output>(endpoint: APIRouter, completion: @escaping WebServiceHandler<Output>) where Output : Decodable {
        
        guard let request = endpoint.createURLRequest() else {
            return completion(.failure(error: WebServiceProtocolError.server))
        }
        
        performDataTask(with: request) { result in
            switch result {
            case .success(let (data, response)):
                if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                    completion(.failure(error: WebServiceProtocolError.parsingFail(error: httpResponse.statusCode.description)))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let responseDecoder = try decoder.decode(Output.self, from: data)
                    completion(.success(modelData: responseDecoder))
                } catch {
                    completion(.failure(error: WebServiceProtocolError.serializationError))
                }

            case .failure(let error):
                if let networkError = error as? URLError {
                    if networkError.code == .notConnectedToInternet {
                        completion(.failure(error: WebServiceProtocolError.noConnection))
                    }
                }
            }
        }

    }
}

private extension APIClient {
    func performDataTask(with request: URLRequest, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let response = response {
                    completion(.success((data, response)))
                } else {
                    completion(.failure(WebServiceProtocolError.notFound))
                }
            }
            task.resume()
        }
}
