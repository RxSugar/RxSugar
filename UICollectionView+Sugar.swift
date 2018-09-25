import UIKit
import RxSwift

extension Sugar where HostType: UICollectionView {
    /**
     RxSugar wrapper for reloading collectionView data.
     */
    public var reloadData: AnyObserver<Void> {
        return valueSetter { (host, _) in host.reloadData() }
    }
}
