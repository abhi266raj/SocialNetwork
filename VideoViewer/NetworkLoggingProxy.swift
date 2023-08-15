//
//  NetworkingProxy.swift
//  VideoViewer
//
//  Created by Abhiraj on 15/08/23.
//

import Foundation
import Service
import OSLog
import ViewModel

class NetworkLoggingProxy: NetworkService {
    let logger = Logger(subsystem: "VideoViewer", category: "Networking")
    func fetchUsing<T>(_ object: T) async throws -> T.ResponseObject.ModelObject where T : Service.NetworkObject {
        let request = "\(object.requestBuilder)"
            logger.log("Making Request \(request, privacy: .private)")
        do {
            let result =  try await realObject.fetchUsing(object)
            let response = "\(result)"
            logger.info("Response Fetched  for \(request, privacy: .private) as \(response, privacy: .private)")
            return result
        }catch {
            logger.error("\(error)")
            throw error
        }
    }
    
    var realObject: NetworkService
    
    init(_ realObject: NetworkService) {
        self.realObject = realObject
    }
}


extension APIRequest: CustomStringConvertible {
    public var description: String {
        self.createRequest().description
    }
}
