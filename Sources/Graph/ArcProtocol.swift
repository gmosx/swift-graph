// TODO: consider arrow (no, category-theory)
// TODO: reserve source/sink for 0-incoming, 0-outgoing nodes
//       - head/tail reminds of List

// Design: directionality is a property of the Edge/Arc (so a graph can
// have both directional and undirectional edges.

/// A directed connection between two nodes
///
/// Supports loops (i.e. arc from node to self).
public protocol ArcProtocol {
    associatedtype Node: Hashable

    var source: Node { get }
    var target: Node { get }
}
