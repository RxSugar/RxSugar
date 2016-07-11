import UIKit
import RxSwift

public extension Sugar where HostType: UIView {

    /**
     RxSugar trigger for setNeedsLayout.
     */
    public var setNeedsLayout: AnyObserver<Void> { return valueSetter { (host, _) in host.setNeedsLayout() } }
    
    /**
     RxSugar trigger for layoutIfNeeded.
     */
    public var layoutIfNeeded: AnyObserver<Void> { return valueSetter { (host, _) in host.layoutIfNeeded() } }

    #if os(tvOS)
    /**
     RxSugar trigger for setNeedsFocusUpdate.
     */
    public var setNeedsFocusUpdate: AnyObserver<Void> { return valueSetter { (host, _) in host.setNeedsFocusUpdate() } }
    
    /**
     RxSugar trigger for updateFocusIfNeeded.
     */
    public var updateFocusIfNeeded: AnyObserver<Void> { return valueSetter { (host, _) in host.updateFocusIfNeeded() } }

    #endif
}