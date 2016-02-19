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
    var forceState: UIGestureRecognizerState = .Ended
    override var state: UIGestureRecognizerState {
        get { return forceState }
        set { self.state = newValue }
    }

    override func addTarget(target: AnyObject, action: Selector) {
        targetActionPair = TargetActionPair(target: target, action: action)
    }
    
    func fireGestureEvent(state: UIGestureRecognizerState) {
        guard let targetAction = self.targetActionPair else { return }
        forceState = state
        targetAction.target.performSelector(targetAction.action, withObject: self)
    }
}

class TestTapGestureRecognizer: UITapGestureRecognizer {
    var targetActionPair: TargetActionPair?
    var forceState: UIGestureRecognizerState = .Ended
    override var state: UIGestureRecognizerState {
        get { return forceState }
        set { self.state = newValue }
    }
    
    override func addTarget(target: AnyObject, action: Selector) {
        targetActionPair = TargetActionPair(target: target, action: action)
    }
    
    func fireGestureEvent(state: UIGestureRecognizerState) {
        guard let targetAction = self.targetActionPair else { return }
        forceState = state
        targetAction.target.performSelector(targetAction.action, withObject: self)
    }
}

class UIGestureRecognizer_SugarTests: XCTestCase {
    func testGestureRecognizerDoesNotFilterEvents() {
        let testObject = TestGestureRecognizer()
        let eventStream = testObject.rxs.events
        
        var events: [String] = []
        _ = eventStream.subscribeNext { _ in events.append("event") }
        
        testObject.fireGestureEvent(.Possible)
        XCTAssertEqual(events, ["event"])
        
        testObject.fireGestureEvent( .Began)
        XCTAssertEqual(events, ["event", "event"])
        
        testObject.fireGestureEvent(.Changed)
        XCTAssertEqual(events, ["event", "event", "event"])
        
        testObject.fireGestureEvent(.Ended)
        XCTAssertEqual(events, ["event", "event", "event", "event"])
    }
    
    func testTapGestureRecognizerSendsRecognizedEvents() {
        let testObject = TestTapGestureRecognizer()
        let eventStream = testObject.rxs.tap
        
        var events: [String] = []
        _ = eventStream.subscribeNext { _ in events.append("tap") }
        
        testObject.fireGestureEvent(.Ended)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent( .Possible)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent(.Changed)
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireGestureEvent(.Ended)
        XCTAssertEqual(events, ["tap", "tap"])
    }
}
