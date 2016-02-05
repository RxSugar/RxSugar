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

/**
 Creates new subscription and sends elements to observer.
 
 In this form it's equivalent to `subscribe` method and visually communicates direction of the flow of information
 
 - parameter observer: Observer that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
 */
@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Destination: ObserverType, Source: ObservableConvertibleType where Source.E == Destination.E>(observer: Destination, observable: Source) -> Disposable {
	return observable.asObservable().subscribe(observer)
}

/**
 Creates new subscription and sends elements to observer.
 
 In this form it's equivalent to `subscribeNext` method and visually communicates direction of the flow of information
 
 - parameter observer: Closure that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
 */
@warn_unused_result(message="http://git.io/rxs.ud")
public func <~<Source: ObservableType>(observer: (Source.E)->Void, observable: Source) -> Disposable {
	return observable.subscribeNext(observer)
}