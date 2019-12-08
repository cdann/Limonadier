//
//  Repository.swift
//  Domain
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright © 2019 mstv. All rights reserved.
//

import Foundation
import RxSwift

public protocol Repository {
    func getRessource() -> Observable<String>
    
    func postUrlItem(url: URL) -> Observable<PlaylistItem>
}
