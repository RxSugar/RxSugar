import XCTest
import Foundation
import RxSwift
import RxSugar

struct TestAnimator: Animator {
    func animate(_ animations: @escaping ()->()) {
        animations()
    }
}

class AnimatorTests: XCTestCase {
    func testAnimatedObservesChangesWithAnimator() {
        let testSubject = PublishSubject<Int>()
        let variable = Variable<Int>(0)
        
        _ = animated(variable.asObserver(), animator: TestAnimator()) <~ testSubject
        
        XCTAssertEqual(variable.value, 0)
        
        testSubject.onNext(42)
        XCTAssertEqual(variable.value, 42)

        testSubject.onNext(7)
        XCTAssertEqual(variable.value, 7)
    }
    
    func testAnimatedObservesChangesInClosureWithAnimator() {
        let testSubject = PublishSubject<Int>()
        let variable = Variable<Int>(0)

        _ = animated(TestAnimator(), closure: { variable.onNext($0) }) <~ testSubject

        XCTAssertEqual(variable.value, 0)
        
        testSubject.onNext(42)
        XCTAssertEqual(variable.value, 42)
        
        testSubject.onNext(7)
        XCTAssertEqual(variable.value, 7)
    }
}
