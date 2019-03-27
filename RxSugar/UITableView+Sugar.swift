import RxSwift

#if os(iOS) || os(tvOS)
import UIKit

public extension Sugar where HostType: UITableView {
    /**
        RxSugar wrapper for reloading tableView data.
     */
    var reloadData: AnyObserver<Void> {
        return valueSetter { (host, _) in host.reloadData() }
    }
}

#endif
