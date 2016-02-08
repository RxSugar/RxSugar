# RxSugar
Simple RxSwift extensions for interacting with Apple APIs.

## Operators that improve visualization of data flow

### _observer_ `<~` _observable_

The `<~` subscribes an observer to an observable. 
_Observer_ can be any `ObserverType`, `Variable`, or `(value)->()`closure. 
_Observable_ can be any `ObservableType`, `Variable`, or `ObservableConvertibleType`. 
This operator returns a `Disposable`.

### _disposableCollection_ `++` _disposable_

The `++` appends a `Disposable` to a collection of disposables (`DisposeBag` or `CompositeDisposable`) and returns the collection.

These operators used in combination result in an easy to visualize data flow:
```
static func bindView(view: View, model: Model, selectionHandler:(SearchResult)->()) {
	view.rxs.disposeBag
		++ view.searchResults <~ model.searchResults
		++ model.searchTerm <~ view.searchTerm
		++ selectionHandler <~ view.selectionEvents
}
```
