import Foundation
import RxSwift

infix operator <~ {
associativity right

// Binds tighter than addition
precedence 141
}

//@warn_unused_result(message="http://git.io/rxs.ud")
//public func <~<O: ObservableType>(variable: Variable<O.E>, observable: O) -> Disposable {
//    return observable.bindTo(variable)
//}
//
//@warn_unused_result(message="http://git.io/rxs.ud")
//public func <~<T>(variable1: Variable<T>, variable2: Variable<T>) -> Disposable {
//    return variable2.asObservable().bindTo(variable1)
//}

@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Source: ObservableType, Destination: ObserverType where Source.E == Destination.E>(observer: Destination, observable: Source) -> Disposable {
	return observable.subscribe(observer)
}

@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Source: ObservableType>(observer: (Source.E)->Void, observable: Source) -> Disposable {
	return observable.subscribeNext(observer)
}