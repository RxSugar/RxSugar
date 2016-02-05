import Foundation
import RxSwift

public protocol RXSObject: AnyObject {}

public extension RXSObject {
    typealias RxsSelfType = Self
    
    public var rxs: Sugar<RxsSelfType> { return Sugar<RxsSelfType>(host: self) }
}

extension NSObject: RXSObject {}

public struct Sugar<HostType: Any> {
    let host:HostType
    
    public init(host: HostType) {
        self.host = host
    }
}

private var disposeBagKey: UInt8 = 0

public extension Sugar where HostType: RXSObject {
    public var onDeinit: Observable<Void> {
        let bag = disposeBag
        return Observable.create { [weak bag] observer in
            bag?.addDisposable(AnonymousDisposable {
                observer.onNext()
                observer.onCompleted()
                })
            
            return NopDisposable.instance
        }
    }
    
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
}