//
//  URLRouter.swift
//  Data
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright © 2019 mstv. All rights reserved.
//

import Foundation
import Alamofire



enum URLRouter : DataRouterConvertible  {
    case getItems
    case postURL(url: URL)
}

extension  URLRouter {
    var baseURL : String {
        return "http://127.0.0.1:5000/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getItems:
            return .get
        case .postURL:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getItems, .postURL:
            return "/items/"
        }
    }
    
    var headers: HTTPHeaders {
        let base : [String: String] = ["Accept": "application/json"]
        
        switch self {
        default:
            break
        }
        return base
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        default: return nil
        }
    }
    
    var params: Data? {
        switch self {
        case let .postURL(url: url):
            return try? JSONEncoder().encode(PlaylistItemUrl(url: url))
        default:
            return nil
        }
    }
    
    
    var url: URL {
        guard let baseUrl = try? self.baseURL.asURL(),
            var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
            else {
                fatalError("base url error")
        }
        components.path.append(path)
        components.queryItems = queryParams
        return components.url!
    }
}



protocol DataRouterConvertible : URLRequestConvertible {
    var method : HTTPMethod {get}
    var url : URL {get}
    var params : Data? {get}
    var headers : HTTPHeaders {get}
}

extension DataRouterConvertible {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        switch self {
        default:
            if let params = params {
                urlRequest.httpBody = params
            }
        }
        return urlRequest
    }
}
