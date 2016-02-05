import RxSwift

public protocol DisposableCollection {
	typealias AddDisposableReturnType
	
	func addDisposable(disposable: Disposable) -> AddDisposableReturnType
}

extension CompositeDisposable: DisposableCollection {
	public typealias AddDisposableReturnType = DisposeKey?
}

extension DisposeBag: DisposableCollection {
	public typealias AddDisposableReturnType = Void
}

// Append Disposable
infix operator ++ {
associativity left

// Binds same as addition
precedence 140
}

/**
 Appends a disposable to another disposable collection, aka a CompositeDisposable or DisposeBag.
 
 In this form it's equivalent to `addDisposable` method and allows chaining of subscriptions
 
 - parameter composite: Disposable collection to add the disposable to.
 - parameter disposable: A disposable to be added to the collection.
 - returns: The disposable collection.
 */
public func ++<T: DisposableCollection>(composite: T, disposable: Disposable) -> T {
	composite.addDisposable(disposable)
	return composite
}
