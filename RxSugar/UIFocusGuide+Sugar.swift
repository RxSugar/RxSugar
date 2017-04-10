import UIKit
import RxSwift

public extension Sugar where HostType: UIFocusGuide {
    /**
     RxSugar wrapper for isEnabled property.
     */
    public var isEnabled: AnyObserver<Bool> { return valueSetter { $0.isEnabled = $1 } }
}
