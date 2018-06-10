import XCTest
@testable import Graph

public struct Arc: ArcProtocol {
    public let source: Int
    public let target: Int
    public let weight: Double
}

fileprivate typealias Graph = ListDigraph<Arc>

class ListDigraphTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        var g = Graph()

        g.insert(arc: Arc(source: 1, target: 2, weight: 0.6))
        g.insert(arc: Arc(source: 1, target: 3, weight: 0.9))
        g.insert(arc: Arc(source: 2, target: 3, weight: 1.2))

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
