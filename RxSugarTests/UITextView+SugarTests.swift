import UIKit
import RxSugar
import XCTest

class UITextView_SugarTests: XCTestCase {
    func testTextViewSendsTextEvents() {
        let testObject = UITextView()
        let eventStream = testObject.rxs.text
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })
        
        testObject.text = "Major Tom"
        NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: testObject)
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "No Event"
        
        testObject.text = "Ground Control"
        NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: testObject)
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
    
    func testTextViewUpdatesText() {
        let testObject = UITextView()
        let observer = testObject.rxs.text
        
        observer.onNext("Major Tom")
        XCTAssertEqual(testObject.text, "Major Tom")
        
        observer.onNext("Ground Control")
        XCTAssertEqual(testObject.text, "Ground Control")
    }
    
    func testTextViewSendsAttributedTextEvents() {
        let testObject = UITextView()
        let eventStream = testObject.rxs.attributedText
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0.string) })
        
        testObject.text = "Major Tom"
        NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: testObject)
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "No Event"
        
        testObject.text = "Ground Control"
        NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: testObject)
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
    
    func testTextViewUpdatesAttributedText() {
        let testObject = UITextView()
        let observer = testObject.rxs.attributedText
        
        let attributedStringOne = NSAttributedString(string: "Major Tom", attributes: ["TestAttribute" : "Value"])
        
        observer.onNext(attributedStringOne)
        XCTAssertEqual(testObject.attributedText.string, attributedStringOne.string)
        XCTAssertEqual(testObject.attributedText.attribute("TestAttribute", at: 0, effectiveRange: nil) as? String, "Value")

        let attributedStringTwo = NSAttributedString(string: "Ground Control", attributes: [NSForegroundColorAttributeName: UIColor.red])

        observer.onNext(attributedStringTwo)
        XCTAssertEqual(testObject.attributedText.string, attributedStringTwo.string)
    }
}
