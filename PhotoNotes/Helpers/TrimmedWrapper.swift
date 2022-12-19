@propertyWrapper
struct Trimmed {
    
    private var value: String = ""
    var wrappedValue: String {
        get {
            return value
        }
        set {
            value = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    
}
