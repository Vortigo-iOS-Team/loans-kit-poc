import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> Void

    private var listener: Listener?
    private var observer: DynamicObserver<T>?

    var value: T {
        didSet {
            observer?.addValue(value)
            callListener()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
    }

    private func callListener() {
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
}
