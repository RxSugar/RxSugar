import Foundation
import RxSwift

precedencegroup ObserverBindingPrecedence {
    associativity: left
    higherThan: AppendDisposablePrecedence
}


infix operator <~ : ObserverBindingPrecedence

/**
 Creates new subscription and sends elements to observer.
 
 In this form it's equivalent to `subscribe` method and visually communicates direction of the flow of information
 
 - parameter observer: Observer that receives events.
 - parameter observable: Observable that sends events.
 - returns: Disposable object that can be used to unsubscribe the observer.
 */

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

public func <~<Source: ObservableType>(observer: @escaping (Source.E)->Void, observable: Source) -> Disposable {
	return observable.subscribeNext(observer)
}
