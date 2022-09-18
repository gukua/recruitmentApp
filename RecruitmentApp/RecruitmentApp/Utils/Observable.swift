import UIKit

public protocol Subscribable {
    associatedtype Observation
    var value: Observation? { get set }
    func subscribe(_ onNext: @escaping (_ value: Observation?) -> Void)
}

public class RawObservable<T>: Subscribable {
    
    public private(set) var subscriptions = [(T?) -> Void]()
    private var observerControls = [WeakControlEventsComplient]()
    
    public var value: T? {
        didSet {
            if Thread.isMainThread {
                notify(oldValue: oldValue, changedTo: value)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.notify(oldValue: oldValue, changedTo: self?.value)
                }
            }
        }
    }
    
    public init() {}
    
    public convenience init(_ initialValue: T?) {
        self.init()
        value = initialValue
    }
    
    public func notify() {
        subscriptions.forEach({ $0(value) })
    }
    
    fileprivate func notify(oldValue: T?, changedTo newValue: T?) {
        subscriptions.forEach({ $0(newValue) })
    }
    
    public func subscribe(_ onNext: @escaping (_ value: T?) -> Void) {
        subscriptions.append(onNext)
        onNext(self.value)  //trigger init value on new subscription
    }
    
    public func bind(to observable: RawObservable) {
        subscribe({ observable.value = $0 })
    }
    
    public func bind<S: Observer>(to observer: S) where S.Observation == T {
        subscribe({ observer.value = $0 })
    }
    
    fileprivate func registerObserver<S: BidirectionalObserver>(_ observer: S) where S.Observation == T {
        observer.addTarget(self, action: #selector(updateValueOnObserverChanged(_:)), for: .allEvents)
        observerControls.append(WeakControlEventsComplient(observer))
    }
    
    @objc private func updateValueOnObserverChanged(_ sender: Any) {
        if let uiTextField = sender as? UITextField {
            value = uiTextField.value as? T
        }
    }
    
    public func dispose() {
        observerControls.forEach({ $0.value?.removeTarget(self, action: nil, for: .allEvents) })
        observerControls.removeAll()
        subscriptions.removeAll()
    }
    
    deinit {
        dispose()
    }
}

public class ArrayRawObservable<T>: RawObservable<[T]> { }

public class ArrayObservable<T: Equatable>: RawObservable<[T]> {
    
    override fileprivate func notify(oldValue: [T]?, changedTo newValue: [T]?) {
        if oldValue ?? [] != newValue ?? [] {
            super.notify(oldValue: oldValue, changedTo: newValue)
        }
    }
    
    public func bidirectionalBind(to observable: ArrayObservable) {
        bind(to: observable)
        observable.bind(to: self)
    }
}

public class Observable<T: Equatable>: RawObservable<T> {
    
    override fileprivate func notify(oldValue: T?, changedTo newValue: T?) {
        if oldValue != newValue {
            super.notify(oldValue: oldValue, changedTo: newValue)
        }
    }
    
    public func bidirectionalBind(to observable: Observable) {
        bind(to: observable)
        observable.bind(to: self)
    }
    
    public func bidirectionalBind<S: BidirectionalObserver>(to observer: S) where S.Observation == T {
        bind(to: observer)
        observer.bind(to: self)
    }
}

//Observer Protocols
public protocol Observer: AnyObject {
    associatedtype Observation
    var value: Observation? { get set }
}

public protocol ControlEventsComplient: AnyObject {
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
    func removeTarget(_ target: Any?, action: Selector?, for controlEvents: UIControl.Event)
}

public protocol BidirectionalObserver: Observer, ControlEventsComplient {
    func bind(to observable: RawObservable<Observation>)
}

public extension BidirectionalObserver {
    
    func bind(to observable: RawObservable<Observation>) {
        observable.registerObserver(self)
    }
}

private class WeakControlEventsComplient {
    
    private(set) weak var value: ControlEventsComplient?
    init (_ value: ControlEventsComplient) {
        self.value = value
    }
}

public extension Array where Element: Subscribable {
    
    func subscribe(_ onNext: @escaping (_ updatedArray: [Element.Observation?]) -> Void) {
        forEach { element in
            element.subscribe { _ in
                onNext(self.map({ $0.value }))
            }
        }
    }
}

extension UITextField: BidirectionalObserver {
    
    public var value: String? {
        get { return text }
        set {
            text = newValue
            sendActions(for: .valueChanged)
        }
    }
}
