import Foundation
import RxSwift

precedencegroup ObserverBindingPrecedence {
    associativity: left
    higherThan: AppendDisposablePrecedence
}

infix operator <~ : ObserverBindingPrecedence

// ~> is already defined in Swift
//infix operator ~> : ObserverBindingPrecedence

/**
 Creates new subscription and sends elements to observer.
 
 In this form it's equivalent to `subscribe` method and visually communicates direction of the flow of information
 
 - parameter observer: Observer that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
*/
public func <~<Destination: ObserverType, Source: ObservableConvertibleType>(observer: Destination, observable: Source) -> Disposable where Source.Element == Destination.Element {
	return observable.asObservable().subscribe(observer)
}

public func ~><Destination: ObserverType, Source: ObservableConvertibleType>(observable: Source, observer: Destination) -> Disposable where Source.Element == Destination.Element {
	return observer <~ observable
}

/**
 Creates new subscription and sends elements to observer.

 In this form it's equivalent to `subscribe` method and visually communicates direction of the flow of information
 
 - parameter observer: Observer that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
*/
public func <~<Destination: ObserverType, Source: ObservableConvertibleType>(observer: Destination, observable: Source) -> RxSwift.Disposable where Optional<Source.Element> == Destination.Element {
	return observable.asObservable().toOptional().subscribe(observer)
}

public func ~><Destination: ObserverType, Source: ObservableConvertibleType>(observable: Source, observer: Destination) -> Disposable where Optional<Source.Element> == Destination.Element {
	return observer <~ observable
}

/**
 Creates new subscription and sends elements to observer.
 
 In this form it's equivalent to `subscribeNext` method and visually communicates direction of the flow of information
 
 - parameter observer: Closure that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
 */

public func <~<Source: ObservableConvertibleType>(observer: @escaping (Source.Element)->Void, observable: Source) -> Disposable {
    return observable.asObservable().subscribe(onNext:(observer))
}

public func ~><Source: ObservableConvertibleType>(observable: Source, observer: @escaping (Source.Element)->Void) -> Disposable {
	return observer <~ observable
}
