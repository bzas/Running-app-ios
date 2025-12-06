import Testing
import Foundation
@testable import GarminKit

struct GarminServiceTests {
    
    @Test func testFetchFitFileWithInvalidDataThrows() async throws {
        let sut = GarminService()
        guard let url = Bundle.module.url(forResource: "TestError", withExtension: "fit") else {
            Issue.record("Missing TestError.fit fixture")
            return
        }
        let data = try Data(contentsOf: url)

        await #expect(throws: Error.self) {
            _ = try await sut.fetchFitFile(from: data)
        }
    }
}
