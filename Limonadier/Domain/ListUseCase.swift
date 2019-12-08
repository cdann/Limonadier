//
//  ListUseCase.swift
//  Domain
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright © 2019 mstv. All rights reserved.
//

import Foundation
import RxSwift

public struct ListUseCase: UseCaseProtocol {
    public typealias ReturnType = String
    public typealias Param = Void
    
    var repository: Repository
    
    public func execute(_ params: Void) -> Observable<String> {
        return repository.getRessource()
    }
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
}
