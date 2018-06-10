public struct ListDigraph<ArcType>: Digraph where ArcType: ArcProtocol {
    var outgoingEdges: [ArcType.Node: ArcType]
    var incomingEdges: [ArcType.Node: ArcType]

    public init() {
        self.outgoingEdges = [:]
        self.incomingEdges = [:]
    }

    public mutating func insert(arc: ArcType) {
    }

    public var arcs: [ArcType] {
        return []
    }
}
