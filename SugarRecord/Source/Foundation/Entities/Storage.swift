import Foundation

public enum StorageType {
    case coreData
}

typealias StorageOperation = ((_ context: Context, _ save: () -> Void) throws -> Void) throws -> Void

public protocol Storage: CustomStringConvertible, Requestable {
        
    var type: StorageType { get }
    var mainContext: Context! { get }
    var saveContext: Context! { get }
    var memoryContext: Context! { get }
    func removeStore() throws
    func operation<T>(_ operation: @escaping (_ context: Context, _ save: @escaping () -> Void) throws -> T) throws -> T
    func backgroundOperation(_ operation: @escaping (_ context: Context, _ save: @escaping () -> Void) -> (), completion: @escaping (Error?) -> ())
    func fetch<T>(_ request: FetchRequest<T>) throws -> [T]
    
}

// MARK: - Storage extension (Fetching)

public extension Storage {

    func fetch<T>(_ request: FetchRequest<T>) throws -> [T] {
        return try self.mainContext.fetch(request)
    }
    
    func count<T>(for request: FetchRequest<T>) throws -> Int {
        return try self.mainContext.count(for: request)
    }
    
}
