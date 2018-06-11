public struct AdjacencyListDigraph<ArcType>: Digraph where ArcType: ArcProtocol {
    public private(set) var arcCount: Int
    public private(set) var adjacentArcs: [ArcType.Node: AdjacentArcs<ArcType>]

    public init() {
        self.arcCount = 0
        self.adjacentArcs = [:]
    }

    public mutating func insert(_ arc: ArcType) {
        adjacentArcs[arc.to, default: AdjacentArcs()].incomingArcs.append(arc)
        adjacentArcs[arc.from, default: AdjacentArcs()].outgoingArcs.append(arc)
        arcCount += 1
    }

    public var arcs: [ArcType] {
        // arcs == incominArcs == outgoingArcs
        return adjacentArcs.reduce([]) { arcs, tuple in
            return arcs + tuple.value.incomingArcs
        }
    }

    public func incomingArcs(to node: ArcType.Node) -> [ArcType]? {
        return adjacentArcs[node]?.incomingArcs
    }

    public func outgoingArcs(from node: ArcType.Node) -> [ArcType]? {
        return adjacentArcs[node]?.outgoingArcs
    }

    public var nodes: [ArcType.Node] {
        return Array(adjacentArcs.keys)
    }

    public var nodeCount: Int {
        return adjacentArcs.count
    }
}
