//
//  NetworkService.swift
//  Service
//
//  Created by Abhiraj on 05/08/23.
//

import Foundation

public protocol NetworkObject {
    associatedtype RequestObject: RequestBuilder
    associatedtype ResponseObject: ResponseBuilder
    
    var requestBuilder: RequestObject { get }
    var responseBuilder: ResponseObject { get }
}

public protocol NetworkService {
    func fetchUsing<T: NetworkObject>(_ object: T) async throws -> T.ResponseObject.ModelObject
}

public protocol RequestBuilder {
    func createRequest() -> URLRequest
}

public protocol ResponseBuilder {
    associatedtype ModelObject
    
    func createResponse(_ data: Data) throws -> ModelObject
}

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession : URLSessionProtocol {
}

public class NetworkServiceImp: NetworkService {
    let session: URLSessionProtocol
    public init(urlSession : URLSessionProtocol = URLSession.shared) {
        self.session = urlSession
    }
    
    public func fetchUsing<T: NetworkObject>(_ object: T) async throws -> T.ResponseObject.ModelObject {
        let request = object.requestBuilder.createRequest()
        
        do {
            let (data, _) = try await session.data(for: request)
            return try object.responseBuilder.createResponse(data)
        } catch {
            throw error
        }
    }
}

public class ModelResponseBuilder<T: Decodable>: ResponseBuilder {
    public typealias ModelObject = T

    public init() {}

    public func createResponse(_ data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}





