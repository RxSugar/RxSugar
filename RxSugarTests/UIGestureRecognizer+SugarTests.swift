import RxSugar
import XCTest
import UIKit
import UIKit.UIGestureRecognizerSubclass

struct TargetActionPair {
    let target: AnyObject
    let action: Selector
}

class TestGestureRecognizer: UIGestureRecognizer {
    var targetActionPair: TargetActionPair?
    var forceState: UIGestureRecognizerState = .ended
    override var state: UIGestureRecognizerState {
        get { return forceState }
        set { self.state = newValue }
    }

    override open func addTarget(_ target: Any, action: Selector) {
        targetActionPair = TargetActionPair(target: target as AnyObject, action: action)
    }
    
    func fireGestureEvent(_ state: UIGestureRecognizerState) {
        guard let targetAction = self.targetActionPair else { return }
        forceState = state
        _ = targetAction.target.perform(targetAction.action, with: self)
    }
}

class TestTapGestureRecognizer: UITapGestureRecognizer {
    var targetActionPair: TargetActionPair?
    var forceState: UIGestureRecognizerState = .ended
    override var state: UIGestureRecognizerState {
        get { return forceState }
        set { self.state = newValue }
    }
    
    override func addTarget(_ target: Any, action: Selector) {
        targetActionPair = TargetActionPair(target: target as AnyObject, action: action)
    }
    
    func fireGestureEvent(_ state: UIGestureRecognizerState) {
        guard let targetAction = self.targetActionPair else { return }
        forceState = state
        _ = targetAction.target.perform(targetAction.action, with: self)
    }
}

class UIGestureRecognizer_SugarTests: XCTestCase {
    func testGestureRecognizerDoesNotFilterEvents() {
        let testObject = TestGestureRecognizer()
        let eventStream = testObject.rxs.events
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { _ in events.append("event") })
        
        testObject.fireGestureEvent(.possible)
        XCTAssertEqual(events, ["event"])
        
        testObject.fireGestureEvent( .began)
        XCTAssertEqual(events, ["event", "event"])
        
        testObject.fireGestureEvent(.changed)
        XCTAssertEqual(events, ["event", "event", "event"])
        
        testObject.fireGestureEvent(.ended)
        XCTAssertEqual(events, ["event", "event", "event", "event"])
    }
    
    func testTapGestureRecognizerSendsRecognizedEvents() {
        let testObject = TestTapGestureRecognizer()
        let eventStream = testObject.rxs.tap
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { _ in events.append("tap") })
        
        testObject.fireGestureEvent(.ended)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent( .possible)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent(.changed)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent(.ended)
        XCTAssertEqual(events, ["tap", "tap"])
    }
}
