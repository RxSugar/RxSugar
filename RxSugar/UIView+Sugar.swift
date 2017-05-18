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

    /**
     RxSugar observer for alpha.
     */
    public var alpha: AnyObserver<CGFloat> { return valueSetter { (host, alpha) in host.alpha = alpha } }
    
    /**
     RxSugar observer for backgroundColor.
     */
    public var backgroundColor: AnyObserver<UIColor> { return valueSetter { (host, color) in host.backgroundColor = color } }
    
    /**
     RxSugar observer for hidden.
     */
    public var hidden: AnyObserver<Bool> { return valueSetter { (host, hidden) in host.isHidden = hidden } }
	
	/**
	RxSugar observer for accessibilityLabel.
	*/
	public var accessibilityLabel: AnyObserver<String?> { return valueSetter { (host, accessibilityLabel) in host.accessibilityLabel = accessibilityLabel } }
	
	/**
	RxSugar observer for accessibilityHint.
	*/
	public var accessibilityHint: AnyObserver<String?> { return valueSetter { (host, accessibilityHint) in host.accessibilityHint = accessibilityHint } }
	
	/**
	RxSugar observer for accessibilityValue.
	*/
	public var accessibilityValue: AnyObserver<String?> { return valueSetter { (host, accessibilityValue) in host.accessibilityValue = accessibilityValue } }
	
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
