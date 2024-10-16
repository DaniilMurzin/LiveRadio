//
//  API.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

protocol APIConfiguration {
    var scheme: String { get }
    var host: String { get }
}

struct API: APIConfiguration {
    let scheme = "https"
    let host = "nl1.api.radio-browser.info"
}
