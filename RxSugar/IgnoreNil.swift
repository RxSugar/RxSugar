import Foundation
import RxSwift

/**
- returns: Observable that ignores nil events and unwraps the optional values.
*/
public extension ObservableType where E: OptionalType {
    public func ignoreNil() -> Observable<E.Wrapped> {
        return filter { $0.hasValue() }
            .map { $0.optional! }
    }
}

/**
- returns: Observable that wraps each value in an optional.
*/
public extension ObservableType {
    public func toOptional() -> Observable<E?> {
        return map { return .some($0) }
    }
}
