public extension Collection {
    subscript(safe index: Index?) -> Iterator.Element? {
        guard let index = index else {
            return nil
        }

        return indices.contains(index) ? self[index] : nil
    }
}
