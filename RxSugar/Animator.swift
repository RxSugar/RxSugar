import UIKit
import RxSwift

/// Respresents an animator.
public protocol Animator {
    /// Called when observing events.
    ///
    /// - parameter animations: A closure called when performing the animation
    func animate(_ animations: @escaping ()->())
}


/// Default animator.
public struct DefaultAnimator: Animator {
    /// Default implementation of an animated observer
    ///
    /// - parameter animations: A closure called when performing the default animation
    public func animate(_ animations: @escaping ()->()) {
        UIView.animate(withDuration: 0.25,
                                   delay: 0,
                                   options: UIViewAnimationOptions.beginFromCurrentState,
                                   animations: animations,
                                   completion: nil)
    }
}

/// Animates changes on an observer with an optional Animator type
///
/// - parameter observer: observer whose changes are animated
/// - parameter animator: an optional custom Animator to perform the animations
///
/// - returns: an animated observer
public func animated<T>(_ observer: AnyObserver<T>, animator: Animator = DefaultAnimator()) -> AnyObserver<T> {
    let subject = PublishSubject<T>()
    
    _ = subject.subscribe(onError: observer.onError, onCompleted: observer.onCompleted)
    _ = subject.subscribe(onNext: { value in
        animator.animate { observer.onNext(value) }
    })
    
    return subject.asObserver()
}

/// Animates changes within a closure with an optional Animator type
///
/// - parameter animator: an optional custom Animator to perform the animations
/// - parameter closure:  a closure that is called when the animations are performed
///
/// - returns: a closure that animates the closure argument
public func animated<T>(_ animator: Animator = DefaultAnimator(), closure: @escaping (T)->()) -> (T) -> () {
    return { value in
        animator.animate { closure(value) }
    }
}
