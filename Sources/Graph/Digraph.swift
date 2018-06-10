public protocol Digraph {
    associatedtype ArcType: ArcProtocol

    mutating func insert(arc: ArcType)
    var arcs: [ArcType] { get } // TODO: make Set
}
