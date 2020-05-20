import XCTest
@testable import ClockWise

final class ClockWiseTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ClockWise().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
