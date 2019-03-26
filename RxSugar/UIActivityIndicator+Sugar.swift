import UIKit
import RxSwift

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
