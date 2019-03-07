import RxSwift
import UIKit

public extension Sugar where HostType: RXSObject {
    /**
     RxSugar wrapper for significantTimeChange
     */
    public var significantTimeChange: Observable<Void> {
        let timeChanges = TargetActionObservable<Void>(
            valueGenerator: {  },
            subscribe: { target, action in
                NotificationCenter.default.addObserver(target, selector: action, name: UIApplication.significantTimeChangeNotification, object: nil)
        },
            unsubscribe: { target, _ in
                NotificationCenter.default.removeObserver(target, name: UIApplication.significantTimeChangeNotification, object: nil)
        },
            complete: host.rxs.onDeinit
        )
        return timeChanges.asObservable()
    }
    
    /**
     RxSugar wrapper for contentSizeCategoryDidChange
     */
    public var contentSizeCategoryDidChange: Observable<Void> {
        let contentSizeCategoryChanges = TargetActionObservable<Void>(
            valueGenerator: {  },
            subscribe: { target, action in
                NotificationCenter.default.addObserver(target, selector: action, name: UIContentSizeCategory.didChangeNotification, object: nil)
        },
            unsubscribe: { target, _ in
                NotificationCenter.default.removeObserver(target, name: UIContentSizeCategory.didChangeNotification, object: nil)
        },
            complete: host.rxs.onDeinit
        )
        return contentSizeCategoryChanges.asObservable()
    }
}
