import RxSwift

extension ObservableType {
    /**
     RxSugar wrapper to map types to Void.
     */
    public func toVoid() -> Observable<Void> {
        return map { (_: Self.Element) -> Void in }
    }
}

extension ObservableType where Self.Element: Collection {
    /**
     RxSugar wrapper to map a collection.
     */
    public func mapCollection<T>(_ mapper: @escaping (Element.Iterator.Element) -> T) -> Observable<[T]> {
        return map { $0.map(mapper) }
    }
}
