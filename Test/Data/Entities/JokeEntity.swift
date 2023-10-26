//
//  JokeEntity.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation



struct JokeEntity: Codable {
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case value
    }
    
    func toDomain()throws -> JokeModel {
        return JokeModel(value: value)
    }
}

