import XCTest
@testable import Graph

public struct Arc: ArcProtocol {
    public let source: Int
    public let target: Int
    public let weight: Double
}

fileprivate typealias Graph = AdjacencyListDigraph<Arc>

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
        g.insert(arc: Arc(source: 1, target: 1, weight: 3.4))

        XCTAssertEqual(g.outgoingArcs(from: 1)?.count, 3)
        XCTAssertEqual(g.outgoingArcs(from: 2)?.count, 1)
        XCTAssertNil(g.outgoingArcs(from: 3))

        XCTAssertEqual(g.incomingArcs(to: 1)?.count, 1)
        XCTAssertEqual(g.incomingArcs(to: 2)?.count, 1)
        XCTAssertEqual(g.incomingArcs(to: 3)?.count, 2)
    }
}
