public protocol OptionalType {
    typealias Wrapped
    
    var optional: Wrapped? { get }
}

extension OptionalType {
    public func hasValue() -> Bool {
        return optional != nil
    }
}

extension Optional: OptionalType {
    public var optional: Wrapped? {
        return self
    }
}
