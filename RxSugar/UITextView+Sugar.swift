import UIKit

public extension Sugar where HostType: UITextView {
	
	/**
	RxSugar wrapper for text property.
	*/
    public var text: ValueBinding<String> {
        let textView = self.host
        let textChanges = TargetActionObservable<String>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.text })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.text = $0 })
    }
		
	/**
	RxSugar wrapper for attributedText property.
	*/
    public var attributedText: ValueBinding<NSAttributedString> {
        let textView = self.host
        let textChanges = TargetActionObservable<NSAttributedString>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.attributedText })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.attributedText = $0 })
    }
}