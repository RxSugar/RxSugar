import RxSwift

var disposeBagKey: UInt8 = 0

extension NSObjectProtocol {
    public var rx_disposeBag: DisposeBag {
        objc_sync_enter(self)
        let bag = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag ?? rx_createAssociatedDisposeBag()
        objc_sync_exit(self)
        return bag
    }
    
    private func rx_createAssociatedDisposeBag() -> DisposeBag {
        let bag = DisposeBag()
        objc_setAssociatedObject(self, &disposeBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bag
    }
}

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
