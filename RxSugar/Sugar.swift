import Foundation
import RxSwift

public struct Sugar<HostType> {
    public let host:HostType
    
    public init(host: HostType) {
        self.host = host
    }
}

public protocol RXSObject: AnyObject {}

public extension RXSObject {
	typealias RxsSelfType = Self
	
	public var rxs: Sugar<RxsSelfType> { return Sugar(host: self) }
}

extension NSObject: RXSObject {}

private var disposeBagKey: UInt8 = 0

public extension Sugar where HostType: RXSObject {
	
	/**
	An Observable<Void> that will send a Next and Completed event upon deinit
	*/
    public var onDeinit: Observable<Void> {
        let bag = disposeBag
        return Observable.create { [weak bag] observer in
            bag?.insert(Disposables.create(with: {
                observer.onNext()
                observer.onCompleted()
                }))
            
            return Disposables.create()
        }
    }
	
	/**
	A DisposeBag that will dispose upon deinit
	*/
    public var disposeBag: DisposeBag {
        objc_sync_enter(host)
        let bag = objc_getAssociatedObject(host, &disposeBagKey) as? DisposeBag ?? createAssociatedDisposeBag()
        objc_sync_exit(host)
        return bag
    }
    
    private func createAssociatedDisposeBag() -> DisposeBag {
        let bag = DisposeBag()
        objc_setAssociatedObject(host, &disposeBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bag
	}
	
	public func valueSetter<T>(_ setter: @escaping (HostType, T)->()) -> AnyObserver<T> {
		return ValueSetter<HostType, T>(host: host, setter: setter).asObserver()
	}
}
