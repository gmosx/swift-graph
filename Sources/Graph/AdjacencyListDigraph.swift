public struct AdjacencyListDigraph<ArcType>: Digraph where ArcType: ArcProtocol {
    var outgoingArcsForNode: [ArcType.Node: [ArcType]]
    var incomingArcsForNode: [ArcType.Node: [ArcType]]

    public init() {
        self.outgoingArcsForNode = [:]
        self.incomingArcsForNode = [:]
    }

    public mutating func insert(_ arc: ArcType) {
        outgoingArcsForNode[arc.from, default: []].append(arc)
        incomingArcsForNode[arc.to, default: []].append(arc)
    }

    public var arcs: [ArcType] {
        return []
    }

    public func outgoingArcs(from node: ArcType.Node) -> [ArcType]? {
        return outgoingArcsForNode[node]
    }

    public func incomingArcs(to node: ArcType.Node) -> [ArcType]? {
        return incomingArcsForNode[node]
    }
}
