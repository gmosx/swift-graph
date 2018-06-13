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


    func testShortestPathsNonReachable() {
        var graph = Graph()

        graph.insert(Arc(from: 0, to: 1, cost: 2))
        graph.insert(Arc(from: 1, to: 3, cost: 7))
        graph.insert(Arc(from: 2, to: 3, cost: 1))

        let bf = BellmanFord(graph: graph, source: 0)

        XCTAssertTrue(bf.hasPath(to: 1))

        XCTAssertTrue(bf.hasPath(to: 3))
        XCTAssertEqual(bf.cost(to: 3), 9)

        XCTAssertNil(bf.path(to: 2))
        XCTAssertFalse(bf.hasPath(to: 2))

        XCTAssertFalse(bf.hasNegativeCycle)
    }

    func testShortestPathsNegativeWeightsNoNegaticeCycle() {
        var graph = Graph()

        graph.insert(Arc(from: 0, to: 1, cost: 2))
        graph.insert(Arc(from: 1, to: 2, cost: 1))
        graph.insert(Arc(from: 1, to: 3, cost: -1))
        graph.insert(Arc(from: 2, to: 3, cost: 1))

        let bf = BellmanFord(graph: graph, source: 0)

        XCTAssertFalse(bf.hasNegativeCycle)

        XCTAssertEqual(bf.cost(to: 3), 1)
    }

    func testShortestPathsWithNegaticeCycle() {
        var graph = Graph()

        graph.insert(Arc(from: 0, to: 1, cost: 2))
        graph.insert(Arc(from: 1, to: 2, cost: 1))
        graph.insert(Arc(from: 1, to: 3, cost: 1))
        graph.insert(Arc(from: 2, to: 3, cost: 1))
        graph.insert(Arc(from: 2, to: 0, cost: -6))

        let bf = BellmanFord(graph: graph, source: 0)

        XCTAssertTrue(bf.hasNegativeCycle)

        let cycle = bf.negativeCycle

        XCTAssertNotNil(cycle)

        if let cycle = cycle {
            XCTAssertEqual(cycle.count, 4)
            XCTAssertTrue(cycle.contains(1))
            XCTAssertTrue(cycle.contains(0))
            XCTAssertTrue(cycle.contains(2))
        }

        print(bf.negativeCycle ?? "no-cycle")
    }

    func testArbitrage() {
        // http://algs4.cs.princeton.edu/44sp/

        let currencies = ["USD", "EUR", "GBP", "CHF", "CAD"]

        let rates: [[Double]] = [
            // USD  EUR    GBP    CHF    CAD
            [1,     0.741, 0.657, 1.061, 1.005], // USD
            [1.349, 1,     0.888, 1.433, 1.366], // EUR
            [1.521, 1.126, 1,     1.614, 1.538], // GBP
            [0.942, 0.698, 0.619, 1,     0.953], // CHF
            [0.995, 0.732, 0.650, 1.049, 1    ]  // CAD
        ]
        
        var graph = Graph()

        for u in 0..<currencies.count {
            for v in 0..<currencies.count {
                if u != v {
                    graph.insert(Arc(from: u, to: v, cost: -log(rates[u][v])))
                }
            }
        }
        
        let bf = BellmanFord(graph: graph, source: 0)

        XCTAssertTrue(bf.hasNegativeCycle)

        if let cycle = bf.negativeCycle {
            for node in cycle {
                print(currencies[node])
            }

            var amount = 1.0

            for i in 1..<cycle.count {
                let c0 = cycle[i - 1]
                let c1 = cycle[i]
                let rate = rates[c0][c1]
                amount *= rate
                print("\(currencies[c0]) -> \(currencies[c1]) :: \(rate) -> \(amount)")
            }
        }
    }
}
