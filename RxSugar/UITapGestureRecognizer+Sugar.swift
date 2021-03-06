import UIKit
import RxSwift

public extension Sugar where HostType: UITapGestureRecognizer {
    /**
     Observable<Void> that sends events for every recognized tap event
     
     - returns: Observable<Void>.
     */
    var tap: Observable<Void> { return tapGesture.map { _ in } }
    
    /**
     Observable<UITapGestureRecognizer> that sends events for every recognized tap event
     
     - returns: Observable<UITapGestureRecognizer>.
     */
    var tapGesture: Observable<HostType> {
        return events.filter { $0.state == .ended }
    }
}
