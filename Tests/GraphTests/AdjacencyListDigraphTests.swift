import XCTest
@testable import Graph

fileprivate struct Arc: ArcProtocol {
    public let from: Int
    public let to: Int
    public let weight: Double
}

fileprivate typealias Graph = AdjacencyListDigraph<Arc>

class ListDigraphTests: XCTestCase {
    func testExample() {
        var g = Graph()

        g.insert(Arc(from: 1, to: 2, weight: 0.6))
        g.insert(Arc(from: 1, to: 3, weight: 0.9))
        g.insert(Arc(from: 2, to: 3, weight: 1.2))
        g.insert(Arc(from: 1, to: 1, weight: 3.4))

        XCTAssertEqual(g.outgoingArcs(from: 1)?.count, 3)
        XCTAssertEqual(g.outgoingArcs(from: 2)?.count, 1)
        XCTAssertEqual(g.outgoingArcs(from: 3)?.count, 0)

        XCTAssertEqual(g.incomingArcs(to: 1)?.count, 1)
        XCTAssertEqual(g.incomingArcs(to: 2)?.count, 1)
        XCTAssertEqual(g.incomingArcs(to: 3)?.count, 2)

        XCTAssertEqual(g.arcs.count, 4)
        XCTAssertEqual(g.arcCount, 4)

        XCTAssertEqual(g.nodes.count, 3)
        XCTAssertEqual(g.nodes[0] + g.nodes[1] + g.nodes[2], 6)
    }
}
