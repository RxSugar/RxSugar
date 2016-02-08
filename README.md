[![Travis CI](https://travis-ci.org/RxSugar/RxSugar.svg?branch=master)](https://travis-ci.org/RxSugar/RxSugar) ![platforms](https://img.shields.io/badge/platforms-iOS-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![pod](https://img.shields.io/cocoapods/v/RxSugar.svg)

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
## Foundation / UIKit extensions
RxSugar adds `Sugar` to all NSObjects as a property called rxs. The rxs property contains RxSwift bindings for many common APIs. Here are a few examples:

### NSObject
`object.rxs.disposeBag` - a collection of dispoasables that will be disposed on deinit

### UIButton
`button.rxs.tap` - an Observable<Void> that sends an event on every `.TouchUpInside` control event.
