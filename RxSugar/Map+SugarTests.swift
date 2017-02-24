import XCTest
import RxSwift
import RxSugar

class Map_SugarTests: XCTestCase {
    func testObservablesMapToVoid() {
        let publishSubject = PublishSubject<Int>()
        var maybeVoid: Any? = nil
            
        _ = { maybeVoid = $0 } <~ publishSubject.toVoid()
        XCTAssertNil(maybeVoid)
        
        publishSubject.onNext(42)
        guard let void = maybeVoid else { XCTFail(); return }
        XCTAssertTrue(void is Void)
    }
    
    func testObservablesMapCollections() {
        let publishSubject = PublishSubject<[Int]>()
        let makeEven = publishSubject.mapCollection { $0 * 2 }
        
        var maybeElements: [Int] = []
        
        _ = { maybeElements = $0 } <~ makeEven
        publishSubject.onNext([1, 3, 5, 7])

        XCTAssertEqual([2, 6, 10, 14], maybeElements)
    }
}
