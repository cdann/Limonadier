//
//  Repository.swift
//  Data
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright © 2019 mstv. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire
import Domain

public class Repository: Domain.Repository {
    
    public func postUrlItem(url: URL) -> Observable<PlaylistItem> {
        let router = URLRouter.postURL(url: url)
        return requestObject(router).map { (response: PlaylistItemResponse) -> PlaylistItem in
            return response.toObject()
        }
    }
    
    public func getRessource() -> Observable<String> {
        let router = URLRouter.postURL(url: URL(fileURLWithPath: ""))
        
        return requestObject(router)
    }
    
    
    let sessionManager: SessionManager
    
    public init() {
        let configuration = URLSessionConfiguration.default
        let manager = Alamofire.SessionManager(configuration: configuration)
        // manager.adapter = RequesrAdapter()
        // manager.retrier = RequestRetrier()
        self.sessionManager = manager
    }
    
    
    
    
    
    func requestObject<T>(_ request: URLRequestConvertible) -> Observable<T> where T: Decodable {
        
        do {
            let UrlRequest = try request.asURLRequest()
            let requestRx = sessionManager.request(UrlRequest).rx
            return requestRx.data()
                .flatMap { (data) -> Observable<T> in
                    let object = try JSONDecoder().decode(T.self, from: data)
                    return Observable.just(object)
            }
        } catch {
            return Observable.error(error)
        }
    }
}
