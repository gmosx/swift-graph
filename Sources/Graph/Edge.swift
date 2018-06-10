/// An undirected connection between two nodes
public protocol Edge {
    associatedtype Node: Hashable

    var u: Node { get }
    var v: Node { get }
}
