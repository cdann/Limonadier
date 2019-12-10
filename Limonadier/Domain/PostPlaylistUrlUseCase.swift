//
//  PostPlaylistUrl.swift
//  Domain
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation
import RxSwift

public struct PostPlaylistUrlUseCase: UseCaseProtocol {
    public typealias ReturnType = PlaylistItem
    public typealias Param = URL
    private var repository : Repository
    
    
    public func execute(_ params: URL) -> Observable<ReturnType> {
        return repository.postUrlItem(url: params)
    }
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
}
