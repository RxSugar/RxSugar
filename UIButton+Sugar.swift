import RxSwift

extension UIButton {
	var rxs_tap: Observable<Void> { return rxs_controlEvents(.TouchUpInside) }
}