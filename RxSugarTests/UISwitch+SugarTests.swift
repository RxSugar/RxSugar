import RxSugar
import XCTest

extension UISwitch: TestControl {}

class UISwitch_SugarTests: XCTestCase {
    func testSwitchSendsEvents() {
        let testObject = UISwitch()
        let eventStream = testObject.rxs.isOn
        
        var events: [Bool] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })
        
        testObject.isOn = true
        testObject.fireControlEvents([UIControl.Event.valueChanged])
        XCTAssertEqual(events, [true])
        
        testObject.isOn = false
        testObject.fireControlEvents([UIControl.Event.valueChanged])
        XCTAssertEqual(events, [true, false])
        
        testObject.isOn = true
        testObject.fireControlEvents([UIControl.Event.valueChanged])
        
        testObject.isOn = false
        testObject.fireControlEvents([UIControl.Event.touchCancel])
        
        testObject.isOn = true
        testObject.fireControlEvents([UIControl.Event.valueChanged])
        XCTAssertEqual(events, [true, false, true, true])
    }
    
    func testSwitchUpdatesValue() {
        let testObject = UISwitch()
        let observer = testObject.rxs.isOn
        
        observer.onNext(true)
        XCTAssertTrue(testObject.isOn)
        
        observer.onNext(false)
        XCTAssertFalse(testObject.isOn)
    }
}
