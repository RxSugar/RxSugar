import UIKit

public extension Sugar where HostType: UITextView {
	
	/**
	RxSugar wrapper for text property.
	*/
    public var text: ValueBinding<String> {
        let textChanges = TargetActionObservable<String>(notificationName: NSNotification.Name.UITextViewTextDidChange.rawValue, onObject: host, valueGenerator: { $0.text })
		return ValueBinding(getter: textChanges, setter: valueSetter { $0.text! = $1 })
    }
		
	/**
	RxSugar wrapper for attributedText property.
	*/
    public var attributedText: ValueBinding<NSAttributedString> {
        let textChanges = TargetActionObservable<NSAttributedString>(notificationName: NSNotification.Name.UITextViewTextDidChange.rawValue, onObject: host, valueGenerator: { $0.attributedText })
        return ValueBinding(getter: textChanges, setter: valueSetter { $0.attributedText! = $1 })
    }
}
