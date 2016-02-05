import Foundation
import RxSwift

infix operator <~ {
associativity right

// Binds tighter than addition
precedence 141
}

extension Variable: ObserverType, ObservableConvertibleType {
    public func asObserver() -> Variable<E> {
        return self
    }
    
    public func on(event: Event<E>) {
        if case .Next(let element) = event {
            value = element
        }
    }
}

@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Source: ObservableConvertibleType, Destination: ObserverType where Source.E == Destination.E>(observer: Destination, observable: Source) -> Disposable {
	return observable.asObservable().subscribe(observer)
}

@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Source: ObservableType>(observer: (Source.E)->Void, observable: Source) -> Disposable {
	return observable.subscribeNext(observer)
}