import RxSwift

extension ObservableType {
    /**
     RxSugar wrapper to map types to Void.
     */
    public func toVoid() -> Observable<Void> {
        return map { (_: Self.E) -> Void in }
    }
}

extension ObservableType where Self.E: Collection {
    /**
     RxSugar wrapper to map a collection.
     */
    public func mapCollection<T>(_ mapper: @escaping (E.Iterator.Element) -> T) -> Observable<[T]> {
        return map { $0.map(mapper) }
    }
}
