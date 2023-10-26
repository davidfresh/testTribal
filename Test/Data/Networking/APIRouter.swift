//
//  APIRouter.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation

private enum URLs: String {
    case randomJoke = "https://api.chucknorris.io/jokes/random"
}

public enum APIRouter {
    case  getRandomJoke
    
    
    private var method: String {
        return "GET"
    }
    
    private var  path: String {
        switch self {
        case .getRandomJoke:
            return URLs.randomJoke.rawValue
        }
    }
}

extension APIRouter {
    func createURLRequest() -> URLRequest? {
        guard let url = URL(string: self.path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        return request
    }
}
