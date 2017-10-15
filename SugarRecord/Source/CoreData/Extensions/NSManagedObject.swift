import Foundation
import CoreData

// MARK: - Entity Protocol

extension NSManagedObject {
    
    open class var entityName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}


// MARK: - NSManagedObject Extension (Entity)

extension NSManagedObject: Entity {}


// MARK: - NSManagedObject (Request builder)

extension NSManagedObject {
    
    
    static func request<T: Entity>(requestable: Requestable) -> FetchRequest<T> {
        return FetchRequest(requestable)
    }

}

//MARK: - NSManagedObject Extension (getting from another context)

public extension NSManagedObject {
    
    private func _inContext<T>(_ context: Context) throws -> T {
        let managedContext = context as! NSManagedObjectContext
        let result = try managedContext.existingObject(with: self.objectID)
        return result as! T
    }
    
    func inContext(_ context: Context) throws -> Self {
        return try _inContext(context)
    }
    
}
