import XCTest
@testable import Graph

fileprivate struct Arc: ArcProtocol, HasCost {
    public let from: Int
    public let to: Int
    public let cost: Double
}

fileprivate typealias Graph = AdjacencyListDigraph<Arc>

class BellmanFordTests: XCTestCase {
    func testShortestPaths() {
        var graph = Graph()

        graph.insert(Arc(from: 0, to: 1, cost: 2))
        graph.insert(Arc(from: 1, to: 2, cost: 1))
        graph.insert(Arc(from: 1, to: 3, cost: 7))
        graph.insert(Arc(from: 2, to: 3, cost: 1))

        let bf = BellmanFord(graph: graph, source: 0)

        XCTAssertEqual(bf.cost(to: 1), 2)
        XCTAssertEqual(bf.cost(to: 2), 3)
        XCTAssertEqual(bf.cost(to: 3), 4)

        XCTAssertFalse(bf.hasNegativeCycle)
    }
}
