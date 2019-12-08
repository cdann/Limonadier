//
//  UseCaseProtocol.swift
//  Domain
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright © 2019 mstv. All rights reserved.
//

import Foundation
import RxSwift

public protocol UseCaseProtocol {
    associatedtype ReturnType
    associatedtype Param
    func execute(_ params: Param) -> Observable<ReturnType>
    init(repository: Repository)
}


public struct UseCase<P, R> {
    public typealias ReturnType = R
    public typealias Param = P
    
    public init<U>(_ useCase: U) where U: UseCaseProtocol, U.ReturnType == ReturnType, U.Param == Param {
        _execute = useCase.execute
    }
    
    public func execute(_ params: P) -> Observable<R> {
        return _execute(params)
    }
    
    let _execute: (P) -> Observable<R>
}
