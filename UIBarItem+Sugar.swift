import RxSwift

#if os(iOS) || os(tvOS)
import UIKit

public extension Sugar where HostType: UIBarItem {
    
    /**
     Reactive setter for isEnabled property
     */
    var isEnabled: AnyObserver<Bool> {
        return valueSetter { $0.isEnabled = $1 }
    }
}

#endif
