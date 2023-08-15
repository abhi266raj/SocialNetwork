//
//  NetworkingProxy.swift
//  VideoViewer
//
//  Created by Abhiraj on 15/08/23.
//

import Foundation
import Service
import OSLog

class NetworkLoggingProxy: NetworkService {
    let logger = Logger(subsystem: "VideoViewer", category: "Networking")
    func fetchUsing<T>(_ object: T) async throws -> T.ResponseObject.ModelObject where T : Service.NetworkObject {
       
        logger.info("Making Request")
        do {
            let result =  try await realObject.fetchUsing(object)
            logger.info("Request Fetched")
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
