import UIKit
import RxSwift

public extension Sugar where HostType: UIView, HostType: RXSObject {

    /**
     RxSugar trigger for setNeedsLayout.
     */
    public var setNeedsLayout: AnyObserver<Void> { return valueSetter { (host, _) in host.setNeedsLayout() } }
}