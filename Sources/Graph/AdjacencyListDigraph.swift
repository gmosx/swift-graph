public struct AdjacencyListDigraph<ArcType>: Digraph where ArcType: ArcProtocol {
    public private(set) var outgoingArcs: [ArcType.Node: [ArcType]]
    public private(set) var incomingArcs: [ArcType.Node: [ArcType]]

    public init() {
        self.outgoingArcs = [:]
        self.incomingArcs = [:]
    }

    public mutating func insert(_ arc: ArcType) {
        outgoingArcs[arc.from, default: []].append(arc)
        incomingArcs[arc.to, default: []].append(arc)
    }

    public var arcs: [ArcType] {
        return []
    }

    public func outgoingArcs(from node: ArcType.Node) -> [ArcType]? {
        return outgoingArcs[node]
    }

    public func incomingArcs(to node: ArcType.Node) -> [ArcType]? {
        return incomingArcs[node]
    }

    public var nodeCount: Int {
        // TODO: temp workaround, how to get the nodeCount?
        return incomingArcs.count + outgoingArcs.count
    }
}
