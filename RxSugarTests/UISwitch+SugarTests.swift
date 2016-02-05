import RxSugar
import XCTest

extension UISwitch: TestControl {}

class UISwitch_SugarTests: XCTestCase {
    func testSwitchSendsEvents() {
        let testObject = UISwitch()
        let eventStream = testObject.rxs.on
        
        var events: [Bool] = []
        _ = eventStream.subscribeNext { events.append($0) }
        
        testObject.on = true
        testObject.fireControlEvents([.ValueChanged])
        XCTAssertEqual(events, [true])
        
        testObject.on = false
        testObject.fireControlEvents([.ValueChanged])
        XCTAssertEqual(events, [true, false])
        
        testObject.on = true
        testObject.fireControlEvents([.ValueChanged])
        
        testObject.on = false
        testObject.fireControlEvents([.TouchCancel])
        
        testObject.on = true
        testObject.fireControlEvents([.ValueChanged])
        XCTAssertEqual(events, [true, false, true, true])
    }
    
    func testSwitchUpdatesValue() {
        let testObject = UISwitch()
        let observer = testObject.rxs.on
        
        observer.onNext(true)
        XCTAssertTrue(testObject.on)
        
        observer.onNext(false)
        XCTAssertFalse(testObject.on)
    }
}