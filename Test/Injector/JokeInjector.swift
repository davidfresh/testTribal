//
//  JokeInjector.swift
//  Test
//
//  Created by David on 26/10/23.
//

import Foundation
public class JokeInjector {
    
    public static func provideJokeUseCase() -> JokeRandomUseCaseContract {
        return JokeRandomUseCase(provider: GetJokeProvaider())
    }
}
