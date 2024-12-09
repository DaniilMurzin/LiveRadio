//
//  Endpoint.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

enum Endpoint {
    case popular
    
    private var scheme: String { "https" }
    private var host: String { "nl1.api.radio-browser.info" }
    
    var path: String {
        switch self {
        case .popular:
            return "/json/stations/topvote"
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
                URLQueryItem(name: "limit", value: "6"),
                URLQueryItem(name: "hidebroken", value: "true")
            ]
        }
        
        return components.url
    }
}
