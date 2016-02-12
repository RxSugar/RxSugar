import UIKit
import RxSwift

public extension Sugar where HostType: UIImageView {
    
    /**
     Reactive setter for image property
     */
    public func selected() -> AnyObserver<UIImage?> {
        return valueSetter { $0.image = $1 }
    }
}