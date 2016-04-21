import UIKit
import RxSwift

extension Sugar where HostType: UIButton, HostType: RXSObject {
	/**
	Observable<Void> that sends event for every .TouchUpInside (iOS) or .PrimaryActionTriggered (tvOS) control event
	*/
	public var tap: Observable<Void> {
        return controlEvents(primaryControlEvent())
    }
	
	public func primaryControlEvent() -> UIControlEvents {
		#if os(iOS)
			return .TouchUpInside
		#elseif os(tvOS)
			return .PrimaryActionTriggered
		#endif
	}
}