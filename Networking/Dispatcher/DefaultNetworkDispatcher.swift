import Foundation

/// The default implementation of the NetworkDispatcher protocol.
 final class DefaultNetworkDispatcher: NetworkDispatcher {
    private let session: URLSessionProtocol

    /// Initializes the DefaultNetworkDispatcher with an optional URLSession instance.
    /// - Parameter session: The URLSession instance to use for network requests. If not provided,
    /// a shared URLSession will be used.
     init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

     func dispatch<Request: RequestType>(_ request: Request) async throws -> Request.ResponseType {
         let urlRequest = try request.asURLRequest()
         let (data, response) = try await session.data(for: urlRequest)
         guard let response = response as? HTTPURLResponse, request.validStatusCode.contains(response.statusCode) else {
             throw NetworkError.invalidResponse
         }
         return try request.responseDecoder(data)
    }

} 
