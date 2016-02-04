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

public func ++<T: DisposableCollection>(composite: T, disposable: Disposable) -> T {
	composite.addDisposable(disposable)
	return composite
}
