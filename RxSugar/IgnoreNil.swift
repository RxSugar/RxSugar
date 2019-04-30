import Foundation
import RxSwift

/**
- returns: Observable that ignores nil events and unwraps the optional values.
*/
public extension ObservableType where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return filter { $0.hasValue() }
            .map { $0.optional! }
    }
}

/**
- returns: Observable that wraps each value in an optional.
*/
public extension ObservableType {
    func toOptional() -> Observable<Element?> {
        return map { return .some($0) }
    }
}
