import Foundation
import RxSwift


/**
Combines the current and most recent previous value of an observable

- parameter resultSelector: (currentValue, previousValue) -> CombinedValue.
- returns: Observable that applies resultSelector to (currentValue, previousValue).
*/
public extension ObservableType {
    func combinePrevious<R>(_ resultSelector: @escaping (Self.Element, Self.Element) throws -> R) -> Observable<R> {
        return Observable.zip(self.asObservable(), self.skip(1), resultSelector: resultSelector)
    }
}
