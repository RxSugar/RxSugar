import RxSwift

#if os(tvOS)
import UIKit

public extension Sugar where HostType: UIFocusGuide {
    /**
     RxSugar wrapper for isEnabled property.
     */
    var isEnabled: AnyObserver<Bool> { return valueSetter { $0.isEnabled = $1 } }
}

#endif
