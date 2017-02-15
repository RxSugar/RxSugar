import RxSwift
import UIKit

public extension Sugar where HostType: RXSObject {
    /**
     RxSugar wrapper for significantTimeChange
     */
    public var significantTimeChange: Observable<Void> {
        let timeChanges = TargetActionObservable<Void>(
            valueGenerator: { _ in },
            subscribe: { target, action in
                NotificationCenter.default.addObserver(target, selector: action, name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
            },
            unsubscribe: { target, _ in
                NotificationCenter.default.removeObserver(target, name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
            },
            complete: host.rxs.onDeinit
        )
        return timeChanges.asObservable()
    }
}
