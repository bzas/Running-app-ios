//
//  GarminImportUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Foundation
import Domain
import TestSupport
import GarminKit
@testable import Application

struct GarminImportUseCaseTests {

    @Test func testImportSessionSucceed() async throws {
        let garminService = GarminServiceMock()
        let repository = WorkoutRepositoryMock()
        let useCase = GarminImportUseCase(
            garminService: garminService,
            repository: repository
        )
        
        let expectedSession = WorkoutSession.mock
        await garminService.setResult(expectedSession)

        let data = Data("fit-data".utf8)
        let tempURL = try writeTempFile(with: data)

        try await useCase.importSession(from: tempURL)

        let saved = await repository.savedSessions
        let lastData = await garminService.lastData
        #expect(saved.count == 1)
        #expect(saved.first?.id == expectedSession.id)
        #expect(lastData == data)
    }

    @Test func testImportSessionFailure() async throws {
        let garminService = GarminServiceMock()
        let repository = WorkoutRepositoryMock()
        let useCase = GarminImportUseCase(
            garminService: garminService,
            repository: repository
        )
        
        await garminService.setError(MockError.sample)

        let data = Data("fit-data".utf8)
        let tempURL = try writeTempFile(with: data)

        await #expect(throws: Error.self) {
            try await useCase.importSession(from: tempURL)
        }
        let saved = await repository.savedSessions
        #expect(saved.isEmpty)
    }
}

// MARK: - Helpers

private extension GarminImportUseCaseTests {
    func writeTempFile(with data: Data) throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try data.write(to: url)
        return url
    }

    enum MockError: Error {
        case sample
    }
}
