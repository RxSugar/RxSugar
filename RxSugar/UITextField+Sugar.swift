import UIKit
import RxSwift

public extension Sugar where HostType: UITextField {
	/**
	RxSugar wrapper for text property.
	*/
	public var text: ValueBinding<String> {
		return controlValueBinding(
            valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.text ?? "" },
			valueSetter: { control, value in
				control.text = value
		})
	}
	
	/**
	RxSugar wrapper for attributedText property.
	*/
	public var attributedText: ValueBinding<NSAttributedString> {
		return controlValueBinding(
            valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.attributedText ?? NSAttributedString() },
			valueSetter: { control, value in
				control.attributedText = value
		})
	}
}