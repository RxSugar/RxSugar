import UIKit
import RxSwift

public extension Sugar where HostType: UIButton {
	/**
	Observable<Void> that sends event for every .TouchUpInside (iOS) or .PrimaryActionTriggered (tvOS) control event
	*/
	var tap: Observable<Void> {
        return controlEvents(primaryControlEvent())
    }
	
	func primaryControlEvent() -> UIControl.Event {
		#if os(iOS)
			return UIControl.Event.touchUpInside
		#elseif os(tvOS)
			return .primaryActionTriggered
		#endif
	}
}
