import RxSwift

extension UITextField {
	var rxs_text: ValueBinding<String> {
		return rxs_controlValueBinding(valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.text ?? "" },
			valueSetter: { control, value in
				control.text = value
		})
	}
	
	var rxs_attributedText: ValueBinding<NSAttributedString> {
		return rxs_controlValueBinding(valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.attributedText ?? NSAttributedString() },
			valueSetter: { control, value in
				control.attributedText = value
		})
	}
}