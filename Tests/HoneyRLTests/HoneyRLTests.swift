import XCTest
@testable import HoneyRL

final class HoneyRLTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HoneyRL().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
