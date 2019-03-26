import UIKit
import RxSwift

public extension Sugar where HostType: UICollectionView {
    /**
     RxSugar wrapper for reloading collectionView data.
     */
    var reloadData: AnyObserver<Void> {
        return valueSetter { (host, _) in host.reloadData() }
    }
}
