//
//  Endpoint.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

enum Endpoint {
    case popular
    case searchByName(String)
    
    private var scheme: String { "http" }
    private var host: String { "162.55.180.156" }
    
    var path: String {
        switch self {
        case .popular:
            return "/json/stations/topvote"
            
        case .searchByName:
            return "/json/stations/search"
        }
    }
    
    func createURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        switch self {
        case .popular:
            components.queryItems = [
                URLQueryItem(name: "limit", value: "15"),
                URLQueryItem(name: "hidebroken", value: "true")
            ]
        case .searchByName(let name):
            components.queryItems = [
                URLQueryItem(name: "limit", value: "25"),
                URLQueryItem(name: "hidebroken", value: "true"),
                URLQueryItem(name: "name", value: name)
            ]
        }
        return components.url
    }
}
