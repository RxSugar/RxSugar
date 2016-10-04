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
    
    func testIgnoreNilSkipsNilEvents() {
        let input = Variable<Int?>(1)
        let output = Variable<Int>(0)
        _ = output <~ input.asObservable().ignoreNil()
        
        XCTAssertEqual(output.value, 1)
        
        input.value = nil
        XCTAssertEqual(output.value, 1)
        
        input.value = 42
        XCTAssertEqual(output.value, 42)
    }
    
    func testCombinePreviousSendsTheLatestTwoValues() {
        let input = Variable<Int>(1)
        let output = Variable<(Int, Int)>(0, 0)
        _ = output <~ input.asObservable().combinePrevious { $0 }
        
        input.value = 2
        XCTAssertEqual(output.value.0, 1)
        XCTAssertEqual(output.value.1, 2)
        
        input.value = 3
        XCTAssertEqual(output.value.0, 2)
        XCTAssertEqual(output.value.1, 3)
    }
    
    func testCompositeAddDisposableOperator() {
        let destination1 = Variable(1)
        let destination2 = Variable(1)
        let source1 = Variable(2)
        let source2 = Variable(3)
        
        let disposable = CompositeDisposable()
            ++ destination1 <~ source1
            ++ destination2 <~ source2
        
        source1.value = 4
        source2.value = 5
        XCTAssertEqual(destination1.value, 4)
        XCTAssertEqual(destination2.value, 5)
        
        disposable.dispose()
        
        source1.value = 6
        source2.value = 7
        XCTAssertEqual(destination1.value, 4)
        XCTAssertEqual(destination2.value, 5)
    }

    func testBagAddDisposableOperator() {
        let destination1 = Variable(1)
        let destination2 = Variable(1)
        let source1 = Variable(2)
        let source2 = Variable(3)
        
        var bag:DisposeBag = DisposeBag()
            ++ destination1 <~ source1
            ++ destination2 <~ source2
        
        source1.value = 4
        source2.value = 5
        XCTAssertEqual(destination1.value, 4)
        XCTAssertEqual(destination2.value, 5)
        
        bag = DisposeBag()
        
        source1.value = 6
        source2.value = 7
        XCTAssertEqual(destination1.value, 4)
        XCTAssertEqual(destination2.value, 5)
        
        _ = bag // suppress variable not read warning
    }
}
