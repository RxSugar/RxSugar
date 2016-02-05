import Foundation

extension RxSugarExtensions where HostType: UITextView {
    var text: ValueBinding<String> {
        let textView = self.host
        let textChanges = TargetActionObservable<String>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.text })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.text = $0 })
    }
    
    var attributedText: ValueBinding<NSAttributedString> {
        let textView = self.host
        let textChanges = TargetActionObservable<NSAttributedString>(notificationName: UITextViewTextDidChangeNotification, onObject: host, valueGenerator: { $0.attributedText })
        return ValueBinding(observable: textChanges, setValue: { [weak textView] in textView?.attributedText = $0 })
    }
}