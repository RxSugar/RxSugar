import RxSwift

#if os(iOS) || os(tvOS)
import UIKit


public extension Sugar where HostType: UICollectionView {
    /**
     RxSugar wrapper for reloading collectionView data.
     */
    var reloadData: AnyObserver<Void> {
        return valueSetter { (host, _) in host.reloadData() }
    }
}

#endif
