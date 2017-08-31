import UIKit
import RxSwift

public extension Sugar where HostType: UILabel {
	
	/**
	RxSugar wrapper for text property.
	*/
	public var text: AnyObserver<String> { return valueSetter { $0.text = $1 } }
	
	/**
	RxSugar wrapper for attributedText property.
	*/
	public var attributedText: AnyObserver<NSAttributedString> { return valueSetter { $0.attributedText = $1 } }
	
	/**
	RxSugar wrapper for textColor property.
	*/
	public var textColor: AnyObserver<UIColor> { return valueSetter { $0.textColor = $1 } }
	
	/**
	RxSugar wrapper for isHighlighted property.
	*/
	public var isHighlighted: AnyObserver<Bool> { return valueSetter { $0.isHighlighted = $1 } }
	
	/**
	RxSugar wrapper for isHighlighted property.
	*/
	public var isEnabled: AnyObserver<Bool> { return valueSetter { $0.isEnabled = $1 } }
}
