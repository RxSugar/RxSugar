import RxSwift

public protocol DisposableCollection {
	associatedtype AddDisposableReturnType
	
	func insert(_ disposable: Disposable) -> AddDisposableReturnType
}

extension CompositeDisposable: DisposableCollection {
	public typealias AddDisposableReturnType = DisposeKey?
}

extension DisposeBag: DisposableCollection {
	public typealias AddDisposableReturnType = Void
}

// Append Disposable
precedencegroup AppendDisposablePrecedence {
    associativity: left
    higherThan: RangeFormationPrecedence // same as Addition
}

infix operator ++: AppendDisposablePrecedence

/**
 Appends a disposable to another disposable collection, aka a CompositeDisposable or DisposeBag.
 
 In this form it's equivalent to `addDisposable` method and allows chaining of subscriptions
 
 - parameter composite: Disposable collection to add the disposable to.
 - parameter disposable: A disposable to be added to the collection.
 - returns: The disposable collection.
 */
@discardableResult
public func ++<T: DisposableCollection>(composite: T, disposable: Disposable) -> T {
	_ = composite.insert(disposable)
	return composite
}
