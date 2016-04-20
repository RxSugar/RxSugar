import UIKit
import RxSwift

public extension Sugar where HostType: UIImageView, HostType: RXSObject {

    /**
     Reactive setter for image property
     */
    public var image: AnyObserver<UIImage?> {
        return valueSetter { $0.image = $1 }
    }
}