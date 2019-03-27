import RxSwift

#if os(iOS) || os(tvOS)
import UIKit

public extension Sugar where HostType: UIActivityIndicatorView {
    /**
     RxSugar wrapper for animating.
     */
    var animating: AnyObserver<Bool> {
        return valueSetter {
            if $1 {
                $0.startAnimating()
            } else {
                $0.stopAnimating()
            }
        }
    }
}

#endif
