import UIKit
import RxSwift

extension Sugar where HostType: UIActivityIndicatorView, HostType: RXSObject {
    /**
     RxSugar wrapper for animating.
     */
    public var animating: AnyObserver<Bool> {
        return valueSetter {
            if $1 {
                $0.startAnimating()
            } else {
                $0.stopAnimating()
            }
        }
    }
}