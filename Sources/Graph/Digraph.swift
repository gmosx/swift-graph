public struct AdjacentArcs<ArcType> {
    public var incomingArcs: [ArcType]
    public var outgoingArcs: [ArcType]

    public init(incomingArcs: [ArcType] = [], outgoingArcs: [ArcType] = []) {
        self.incomingArcs = incomingArcs
        self.outgoingArcs = outgoingArcs
    }
}

public protocol Digraph {
    associatedtype ArcType: ArcProtocol

    var adjacentArcs: [ArcType.Node: AdjacentArcs<ArcType>] { get }

    mutating func insert(_ arc: ArcType)
    var arcs: [ArcType] { get } // TODO: make Set

    func outgoingArcs(from node: ArcType.Node) -> [ArcType]?
    func incomingArcs(to node: ArcType.Node) -> [ArcType]?

    var nodeCount: Int { get }
}
