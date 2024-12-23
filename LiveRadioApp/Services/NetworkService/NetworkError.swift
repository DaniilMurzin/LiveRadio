//
//  NetworkError.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL // Некорректный URL.
    case noData // Сервер не вернул никаких данных.
    case invalidResponse(URLResponse) // Ответ не является HTTP-ответом.
    case serviceUnavailable // Сервер временно недоступен (код 503).
    case serverError(statusCode: Int, message: String) // Общая ошибка сервера (коды 500-599).
    case badRequest(message: String) // Неправильный запрос (код 400).
    case unauthorized(message: String) // Ошибка авторизации (код 401).
    case forbidden(message: String) // Доступ запрещён (код 403).
    case notFound(message: String) // Ресурс не найден (код 404).
    case unknown(Error) // Неизвестная ошибка.
    
    init?(statusCode: Int ) {
        switch statusCode {
        case 200...299: return nil
        case 503: self = .serviceUnavailable
        case 500...599: self = .serverError(statusCode: statusCode, message: "Server error occurred")
        case 400: self = .badRequest(message: "Bad Request")
        case 401: self = .unauthorized(message: "Unauthorized Access")
        case 403: self = .forbidden(message: "Forbidden")
        case 404: self = .notFound(message: "Resource Not Found")
        default: return nil
        }
    }
    
    @inlinable
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
