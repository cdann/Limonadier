//
//  GetPlaylistUseCase.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import RxSwift

public struct GetPlaylistUseCase: UseCaseProtocol {
    public typealias ReturnType = Playlist
    public typealias Param = Void
    private var repository : Repository
    
    
    public func execute(_ params: Param) -> Observable<ReturnType> {
        return repository.getPlaylist()
    }
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
}
