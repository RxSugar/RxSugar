import RxSwift

#if os(iOS) || os(tvOS)
import UIKit

public extension Sugar where HostType: UIImageView {

    /**
     Reactive setter for image property
     */
    var image: AnyObserver<UIImage?> {
        return valueSetter { $0.image = $1 }
    }
}

#endif
