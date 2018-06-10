/// A directed connection between two nodes
///
/// Supports loops (i.e. arc from node to self).
public protocol Arc: Edge {
    var source: Node { get }
    var target: Node { get }
}

extension Arc {
    public var u: Node {
        return source
    }

    public var v: Node {
        return target
    }
}
