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

public func <~<Destination: ObserverType, Source: ObservableConvertibleType>(observer: Destination, observable: Source) -> Disposable where Source.E == Destination.E {
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
    return observable.subscribe(onNext:(observer))
}

/**
 Creates a "weak" observer from a class instance method.
 
 This is intended to help avoid retain cycles.
 
 - parameter t: Object instance that method should be called on.
 - parameter curriedObserver: Curried closure that takes a T and returns an observer.
 - returns: Observer with a weak reference to the object instance.
 
 To prevent retain cycles, avoid doing this:
      disposeBag ++ self.someFunction <~ someObservable
 and instead do this:
      disposeBag ++ self <~ MyClass.someFunction <~ someObservable
 */
public func <~<T: AnyObject, E>(_ t: T, curriedObserver: @escaping (T)->(E)->Void) -> (E)->Void {
    return {
        [weak t] e in
        if let t = t {
            curriedObserver(t)(e)
        }
    }
}
