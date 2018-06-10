// TODO: Somehow support a graph with arcs *and* edges!

/// An undirected connection between two nodes
public protocol EdgeProtocol {
    associatedtype Node: Hashable

    var u: Node { get }
    var v: Node { get }
}
