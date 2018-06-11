public struct AdjacencyListDigraph<ArcType>: Digraph where ArcType: ArcProtocol {
    public private(set) var adjacentArcs: [ArcType.Node: AdjacentArcs<ArcType>]

    public init() {
        self.adjacentArcs = [:]
    }

    public mutating func insert(_ arc: ArcType) {
        adjacentArcs[arc.to, default: AdjacentArcs()].incomingArcs.append(arc)
        adjacentArcs[arc.from, default: AdjacentArcs()].outgoingArcs.append(arc)
    }

    public var arcs: [ArcType] {
        return [] // TODO: implement
    }

    public func incomingArcs(to node: ArcType.Node) -> [ArcType]? {
        return adjacentArcs[node]?.incomingArcs
    }

    public func outgoingArcs(from node: ArcType.Node) -> [ArcType]? {
        return adjacentArcs[node]?.outgoingArcs
    }

    public var nodeCount: Int {
        return adjacentArcs.count
    }
}
