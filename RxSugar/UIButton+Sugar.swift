import UIKit
import RxSwift

extension Sugar where HostType: UIButton {
	/**
	Observable<Void> that sends event for every .TouchUpInside (iOS) or .PrimaryActionTriggered (tvOS) control event
	*/
	public var tap: Observable<Void> {
        return controlEvents(primaryControlEvent())
    }
	
	public func primaryControlEvent() -> UIControlEvents {
		#if os(iOS)
			return .touchUpInside
		#elseif os(tvOS)
			return .primaryActionTriggered
		#endif
	}
}
