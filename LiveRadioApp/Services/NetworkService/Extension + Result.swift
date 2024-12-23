//
//  Extension + Result.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 11.12.2024.
//

extension Result where Failure == Error {
    @inlinable
    init(asyncCatch: () async throws -> Success) async {
        do {
            let success = try await asyncCatch()
            self = .success(success)
        } catch {
            self = .failure(error)
        }
    }
}

extension Result {
    @inlinable
    func asyncTryMap<NewSuccess>(
        _ transform: (Success) async throws -> NewSuccess
    ) async -> Result<NewSuccess, Error> {
        switch self {
        case .success(let success):
            return await Result<NewSuccess, Error> {
                try await transform(success)
            }
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
