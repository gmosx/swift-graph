public protocol Digraph {
    associatedtype ArcType: Arc

    func insert(arc: ArcType)
    var arcs: [ArcType] { get } // TODO: make Set
}
