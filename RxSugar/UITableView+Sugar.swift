import UIKit
import RxSwift

public extension Sugar where HostType: UITableView {
    /**
        RxSugar wrapper for reloading tableView data.
     */
    var reloadData: AnyObserver<Void> {
        return valueSetter { (host, _) in host.reloadData() }
    }
}
