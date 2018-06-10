public protocol Digraph {
    associatedtype ArcType: ArcProtocol

    mutating func insert(_ arc: ArcType)
    var arcs: [ArcType] { get } // TODO: make Set
    
    func outgoingArcs(from node: ArcType.Node) -> [ArcType]?
    func incomingArcs(to node: ArcType.Node) -> [ArcType]?
}
