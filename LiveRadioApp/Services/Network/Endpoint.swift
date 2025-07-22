//
//  Endpoint.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

extension URLComponents {
    static var backend: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "162.55.180.156"
        return components
    }
    
    private func reduce(_ transform: (inout Self) -> Void) -> URLComponents {
        var copy = self
        transform(&copy)
        return copy
    }
    
    func withPath(_ path: String) -> URLComponents {
        reduce { $0.path = "/" + path }
    }
    
    func addPath(_ path: String) -> URLComponents {
        reduce {
            $0.path = $0.path
                .appending("/")
                .appending(path)
        }
    }
    
    func withQueryItem(_ item: URLQueryItem) -> URLComponents {
        reduce {
            if $0.queryItems == nil {
               $0.queryItems = [item]
                return
            }
            $0.queryItems?.append(item)
        }
    }
    
    func withQueryItems(_ item: URLQueryItem...) -> URLComponents {
        item.reduce(self) { $0.withQueryItem($1) }
    }
    
    func withLimit(_ limit: Int = 25) -> URLComponents {
        self.withQueryItems(
            URLQueryItem(name: "limit", value: limit.description),
            URLQueryItem(name: "hidebroken", value: "true")
        )
    }
    
    static func stations(_ path: String) -> URLComponents {
        URLComponents.backend
            .withPath("json")
            .addPath("stations")
            .addPath(path)
    }
    
    static func topVotes() -> URLComponents {
        URLComponents
            .stations("topvote")
            .withLimit()
    }
    
    static func search(_ query: String) -> URLComponents {
        URLComponents
            .stations("search")
            .withLimit()
            .withQueryItem(URLQueryItem(name: "name", value: query))
    }
    
    func unwrapURL(
        throwing error: @autoclosure () -> Error = NetworkError.invalidURL
    ) throws -> URL {
        guard let url else {
            throw error()
        }
        return url
    }
}

//enum Endpoint {
//    case popular
//    case searchByName(String)
//    
//    private var scheme: String { "http" }
//    private var host: String { "162.55.180.156" }
//    
//    var path: String {
//        switch self {
//        case .popular:
//            return "/json/stations/topvote"
//            
//        case .searchByName:
//            return "/json/stations/search"
//        }
//    }
//    
//    func createURL() -> URL? {
//        var components = URLComponents()
//        components.scheme = scheme
//        components.host = host
//        components.path = path
//        
//        switch self {
//        case .popular:
//            components.queryItems = [
//                URLQueryItem(name: "limit", value: "15"),
//                URLQueryItem(name: "hidebroken", value: "true")
//            ]
//        case .searchByName(let name):
//            components.queryItems = [
//                URLQueryItem(name: "limit", value: "25"),
//                URLQueryItem(name: "hidebroken", value: "true"),
//                URLQueryItem(name: "name", value: name)
//            ]
//        }
//        return components.url
//    }
//}
