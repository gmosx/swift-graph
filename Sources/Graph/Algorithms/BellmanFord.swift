// http://algs4.cs.princeton.edu/44sp/
// http://algs4.cs.princeton.edu/44sp/BellmanFordSP.java.html
// https://gist.github.com/romanroibu/4cf35cb242e3539b9f82
// http://algo.epfl.ch/_media/en/courses/2011-2012/algorithmique-cycles-2011a.pdf

// TODO: specialized BellmanFord for Node == Int
// TODO: try to avoid nodes and nodeCount
// TODO: pass nodeCount?
// TODO: consider passing KeyPath to the cost member
// TODO: just a simple implementation, need to imnplement properly at some point.

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
            for (_, adjacentArcs) in graph.adjacentArcs {
                for arc in adjacentArcs.outgoingArcs {
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

    public func hasPath(to node: Node) -> Bool {
        return predecessors[node] != nil
    }

    public func path(to node: Node) -> [Graph.ArcType]? {
        if let predecessor = predecessors[node] {
            if let currentPath = path(to: predecessor) {
                return currentPath + graph.incomingArcs(to: node)!
            } else {
                return graph.incomingArcs(to: node)
            }
        } else {
            return nil
        }
    }

    public var hasNegativeCycle: Bool {
        for (node, adjacentArcs) in graph.adjacentArcs {
            for arc in adjacentArcs.outgoingArcs {
                if costs[node] + arc.cost < costs[arc.to] {
                    return true
                }
            }
        }

        return false
    }

    public var negativeCycle: [Node]? {
        for node in 0..<graph.nodeCount {
            for arc in graph.outgoingArcs(from: node)! {
                let target = arc.to
                let cost = arc.cost
                if costs[node] + cost < costs[target] {
                    // Negative-weight cycle detected, walk the predecessors
                    // to build the cycle path.
                    return walkCycle(node: target, cycle: [target])
                }
            }
        }

        return nil
    }

    func walkCycle(node: Node, cycle: [Node]) -> [Node] {
        if let predecessor = predecessors[node] {
            if cycle.contains(predecessor) {
                var nextCycle = cycle
                nextCycle.append(node)
                return nextCycle
            } else {
                var nextCycle = walkCycle(node: predecessor, cycle: cycle)
                nextCycle.append(node)
                return nextCycle
            }
        } else {
            return cycle
        }
    }
}
