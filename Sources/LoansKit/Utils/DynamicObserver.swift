final class DynamicObserver<T> {
    private(set) var values: [T] = []

    init() {}

    func addValue(_ value: T) {
        values.append(value)
    }
}
