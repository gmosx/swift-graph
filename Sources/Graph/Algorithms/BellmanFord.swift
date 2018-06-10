// http://algs4.cs.princeton.edu/44sp/
// http://algs4.cs.princeton.edu/44sp/BellmanFordSP.java.html
// https://gist.github.com/romanroibu/4cf35cb242e3539b9f82
// http://algo.epfl.ch/_media/en/courses/2011-2012/algorithmique-cycles-2011a.pdf

// TODO: specialized BellmanFord for Node == Int
// TODO: try to avoid nodes and nodeCount
// TODO: pass nodeCount?

public protocol HasCost {
    var cost: Double { get }
}

public struct BellmanFord<Graph> where Graph: Digraph, Graph.ArcType.Node == Int, Graph.ArcType: HasCost {
    public typealias Node = Graph.ArcType.Node

    let graph: Graph
    var costs: [Double]
    var predecessors: [Node?]
    var incomingArcs: [Graph.ArcType?]

    public init(graph: Graph, source: Node) {
        self.graph = graph

        costs = [Double](repeating: Double.infinity, count: graph.nodeCount)
        costs[source] = 0

        predecessors = Array(repeating: nil, count: graph.nodeCount)
        incomingArcs = Array(repeating: nil, count: graph.nodeCount)

        // TODO: convert to optimized version that uses a queue to avoid
        // visiting already processed nodes.

        for _ in 1..<graph.nodeCount {
            for (_, arcs) in graph.outgoingArcs {
                for arc in arcs {
                    relax(arc: arc)
                }
            }
        }
    }

    mutating func relax(arc: Graph.ArcType) {
        let cost = arc.cost
        if costs[arc.to] > costs[arc.from] + cost {
            costs[arc.to] = costs[arc.from] + cost
            predecessors[arc.to] = arc.from
            incomingArcs[arc.to] = arc
        }
    }

    // TODO: rename to shortestPathCost?
    public func cost(to node: Node) -> Double {
        return costs[node]
    }

    public var hasNegativeCycle: Bool {
        for (node, arcs) in graph.outgoingArcs {
            for arc in arcs {
                if costs[node] + arc.cost < costs[arc.to] {
                    return true
                }
            }
        }

        return false
    }

    public var negativeCycle: [Node]? {
        return []
    }
}
