import XCTest
import RxSwift
import RxSugar

class PlainClass {
    static var LiveInstances = 0
    
    init() {
        PlainClass.LiveInstances += 1
    }
    
    deinit {
        PlainClass.LiveInstances -= 1
    }
    
    func getRidOfWarning() {}
}

let simpleObservable = PublishSubject<Void>()

class ArrowSubscribingClass: PlainClass {
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
//         disposeBag ++ self.test <~ simpleObservable   /// This creates a retain cycle and causes test to fail
        disposeBag ++ self <~ ArrowSubscribingClass.test <~ simpleObservable
    }
    
    var testCalled = 0
    func test() {
        testCalled += 1
    }
}

class RetainCycleTests: XCTestCase {
    
    override func setUp() {
        PlainClass.LiveInstances = 0
    }
    
    func test_plainClass_deinits() {
        XCTAssertEqual(PlainClass.LiveInstances, 0)
        
        var plainClass: PlainClass? = PlainClass()
        plainClass?.getRidOfWarning()
        
        XCTAssertEqual(PlainClass.LiveInstances, 1)
        
        plainClass = nil
        
        XCTAssertEqual(PlainClass.LiveInstances, 0)
    }
    
    func test_arrowSubscribingClass_deinits() {
        XCTAssertEqual(ArrowSubscribingClass.LiveInstances, 0)
        
        var arrowSubscribingClass : ArrowSubscribingClass? = ArrowSubscribingClass()
        
        XCTAssertEqual(ArrowSubscribingClass.LiveInstances, 1)
        
        simpleObservable.onNext(())
        XCTAssertEqual(arrowSubscribingClass?.testCalled, 1)
        
        arrowSubscribingClass = nil
        
        XCTAssertEqual(ArrowSubscribingClass.LiveInstances, 0)
    }
}
