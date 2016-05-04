import UIKit
import RxSwift

public extension Sugar where HostType: UIGestureRecognizer {
    /**
     Observable<UIGestureRecognizer> that sends events for every state change

     - returns: Observable<UIGestureRecognizer>.
     */
    public var events: Observable<HostType> {
        let events = TargetActionObservable<HostType>(
            valueGenerator: { [unowned host] in
                return host
            },
            subscribe: { [unowned host] (target, action) in
                host.addTarget(target, action: action)
            },
            unsubscribe: { [weak host] (target, action) in
                host?.removeTarget(target, action: action)
            },
            complete: onDeinit
        )
        return events.asObservable()
    }
}
