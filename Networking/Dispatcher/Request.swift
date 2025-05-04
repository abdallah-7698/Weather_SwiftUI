import Foundation

/// A typealias that combines the `TargetType` and `ResponseDecoder` protocols.
//public typealias RequestType = TargetType & ResponseDecoder

public protocol RequestType: TargetType & ResponseDecoder { }
 
public extension RequestType {
    func perform(_ seconds: TimeInterval = 10) async throws -> ResponseType {
        return try await withTimeOut(seconds) {
           try await DefaultNetworkDispatcher().dispatch(self)
        }
    }
    
    private func withTimeOut<T>(_ seconds: TimeInterval, operation: @escaping () async throws -> T) async throws -> T {
        return try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask { try await operation() }
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                throw NetworkError.timeOutRequest
            }
            return try await group.next()!
        }
    }
}
