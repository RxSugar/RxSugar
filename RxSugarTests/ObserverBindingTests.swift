import XCTest
import RxSwift
import RxSugar

class ObserverBindingTests: XCTestCase {
    func testVariableBindsToObservable() {
        let testObject = Variable("")
        let eventStream = PublishSubject<String>()
        let disposable = CompositeDisposable()
        
        disposable ++ testObject <~ eventStream
        
        eventStream.onNext("Major Tom")
        XCTAssertEqual(testObject.value, "Major Tom")
        
        disposable.dispose()
        
        eventStream.onNext("Ground Control")
        XCTAssertEqual(testObject.value, "Major Tom")
    }
    
    func testVariableBindsToVariable() {
        let testObject = Variable("")
        let eventStream = Variable("")
        let disposable = CompositeDisposable()
        
        disposable ++ testObject <~ eventStream
        
        eventStream.value = "Major Tom"
        XCTAssertEqual(testObject.value, "Major Tom")
        
        disposable.dispose()
        
        eventStream.value = "Ground Control"
        XCTAssertEqual(testObject.value, "Major Tom")
    }
    
    func testObserverBindsToObserverable() {
        let testObject = BehaviorSubject<String>(value: "").asObserver()
        let eventStream = PublishSubject<String>()
        let disposable = CompositeDisposable()
        
        disposable ++ testObject <~ eventStream
        
        eventStream.onNext("Major Tom")
        XCTAssertEqual(try! testObject.value(), "Major Tom")
        
        disposable.dispose()
        
        eventStream.onNext("Ground Control")
        XCTAssertEqual(try! testObject.value(), "Major Tom")
    }
    
    func testObservableBindsToObserver() {
        let testObject = BehaviorSubject<String>(value: "")
        let eventStream = BehaviorSubject<String>(value: "").asObserver()
        let disposable = CompositeDisposable()
        
        disposable ++ testObject <~ eventStream
        
        eventStream.onNext("Major Tom")
        XCTAssertEqual(try! testObject.value(), "Major Tom")
        
        disposable.dispose()
        
        eventStream.onNext("Ground Control")
        XCTAssertEqual(try! testObject.value(), "Major Tom")
    }

}