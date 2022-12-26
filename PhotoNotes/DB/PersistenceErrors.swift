import Foundation

public enum PersistenceError: String, Error {
    
    case PhotoNoteEntityCreation = "Can't create note DB entity"
    case PhotoNoteEntityDelete = "Can't delete note DB entity"
    case PhotoNoteEntityParsing = "Can't parse entity property"
    
}

extension PersistenceError: CustomStringConvertible {
    public var description : String {
        switch self {
        default: return self.rawValue
        }
    }
}
