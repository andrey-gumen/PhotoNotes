import CoreData
import UIKit

struct PersistenceController {
    
    let container: NSPersistentContainer
    
    // MARK: Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0 ..< 10 {
            let newItem = PhotoNoteEntity(context: viewContext)
            newItem.date = Date.randomBetween(start: Date(timeIntervalSince1970: CFTimeInterval(0)), end: Date.now)
            newItem.image = nil
            newItem.note = "test"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    // MARK: runtime
    static let shared = PersistenceController()
    
    var managedContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "PhotoNotes")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func add(note: PhotoNote) -> Result<Void, Error> {
        if let entity = NSEntityDescription.entity(forEntityName: PhotoNoteEntityConstants.Name, in: managedContext) {
            do {
                let storage = NSManagedObject(entity: entity, insertInto: managedContext)
                storage.setValue(note.date, forKey: PhotoNoteEntityConstants.DateKey)
                storage.setValue(note.image?.pngData(), forKey: PhotoNoteEntityConstants.ImageKey)
                storage.setValue(note.note, forKey: PhotoNoteEntityConstants.NoteKey)
                
                try managedContext.save()
                return .success(Void())
            } catch let error as NSError {
                return .failure(error)
            }
        } else {
            return .failure(PersistenceError.PhotoNoteEntityCreation)
        }
    }

    func delete(offsets: IndexSet) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: PhotoNoteEntityConstants.Name)

        do {
            let objects = try managedContext.fetch(fetchRequest)
            offsets.map { objects[$0] }.forEach(managedContext.delete)

            try managedContext.save()
            return .success(Void())
        } catch let error as NSError {
            return .failure(error)
        }
    }

    func getNotes() -> Result<[PhotoNote], Error> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: PhotoNoteEntityConstants.Name)

        do {
            let objects = try managedContext.fetch(fetchRequest)
            var notes = [PhotoNote]()
            for (index, object) in objects.enumerated() {
                do {
                    let photoNote = try PersistenceController.getNote(object)
                    notes.append(photoNote)
                } catch {
                    print("object \(index): \(error)")
                }
            }
            return .success(notes)
        } catch let error as NSError {
            return .failure(error)
        }
    }
    

    // MARK: Helpers

    private static func getNote(_ object: NSManagedObject) throws -> PhotoNote {
        guard let date = object.value(forKey: PhotoNoteEntityConstants.DateKey) as? Date else {
            throw PersistenceError.PhotoNoteEntityParsing
        }
        
        let image = try getImage(key: PhotoNoteEntityConstants.ImageKey, object: object)
        let note = object.value(forKey: PhotoNoteEntityConstants.NoteKey) as? String
        
        return PhotoNote(
            date: date,
            image: image,
            note: note
        )
    }

    private static func getImage(key: String, object: NSManagedObject) throws -> UIImage?  {
        let imageData = object.value(forKey: key) as? Data
        guard let imageData else {
            return nil
        }
        
        guard let image = UIImage(data: imageData) else {
            throw PersistenceError.PhotoNoteEntityParsing
        }
        return image
    }
    
}

private extension PersistenceController {
    
    // MARK: PhotoNote entity constants
    struct PhotoNoteEntityConstants {
        static let Name = "PhotoNoteEntity"
        static let DateKey = "date"
        static let ImageKey = "image"
        static let NoteKey = "note"
    }
    
}

