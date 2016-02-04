import RxSwift

extension RxSugarExtensions where HostType: UIButton {
	var tap: Observable<Void> { return controlEvents(.TouchUpInside) }
}