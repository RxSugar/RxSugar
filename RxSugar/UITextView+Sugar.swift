import Foundation

public extension Sugar where HostType: UITextView {
    public var text: ValueBinding<String> {
        let textView = self.host
        let textChanges = TargetActionObservable<String>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.text })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.text = $0 })
    }
    
    public var attributedText: ValueBinding<NSAttributedString> {
        let textView = self.host
        let textChanges = TargetActionObservable<NSAttributedString>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.attributedText })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.attributedText = $0 })
    }
}