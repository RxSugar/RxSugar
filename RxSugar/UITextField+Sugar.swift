import UIKit
import RxSwift

public extension Sugar where HostType: UITextField {
	/**
	RxSugar wrapper for text property.
	*/
	public var text: ValueBinding<String> {
		return controlValueBinding(
            valueChangeEventTypes: [.editingChanged, .editingDidEnd],
			getter: { $0.text ?? "" },
			setter: { $0.text = $1 })
	}
	
	/**
	RxSugar wrapper for attributedText property.
	*/
	public var attributedText: ValueBinding<NSAttributedString> {
		return controlValueBinding(
            valueChangeEventTypes: [.editingChanged, .editingDidEnd],
			getter: { $0.attributedText ?? NSAttributedString() },
			setter: { $0.attributedText = $1 })
	}
}
