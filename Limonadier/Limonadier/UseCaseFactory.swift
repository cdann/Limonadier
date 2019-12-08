//
//  useCaseFactory.swift
//  limonadier
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation
import DataLayer
import Domain

typealias RepositoryProtocol = Domain.Repository

class UseCaseFactory {
    var repository: RepositoryProtocol
    static var instance: UseCaseFactory!

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func createUseCase<UC: UseCaseProtocol>(_ type: UC.Type) -> UseCase<UC.Param, UC.ReturnType> {
        return UseCase<UC.Param, UC.ReturnType>(UC(repository: self.repository))
    }
}
