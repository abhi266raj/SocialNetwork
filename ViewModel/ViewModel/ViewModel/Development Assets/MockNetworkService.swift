//
//  JsonData.swift
//  ViewModel
//
//  Created by Abhiraj on 09/08/23.
//

import Foundation
import Service
import SwiftUI

public class MockNetworkService: NetworkService {
    
    public init(){
        
    }
    
    lazy var bundle: Bundle? = {
        if let bundleURL = Bundle(for: Self.self).url(forResource: "Bundle", withExtension: "bundle") {
            return Bundle(url: bundleURL)
        }
        return nil
    }()
    
    fileprivate func data(jsonFilePath: String) -> Data? {
        if let jsonPath = bundle?.path(forResource: jsonFilePath, ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            return jsonData
        }
        return nil
    }
    
    
    public func fetchUsing<T: NetworkObject>(_ object: T) async throws -> T.ResponseObject.ModelObject {
        let url = object.requestBuilder.createRequest().url
        if let path = url?.path {
            print("Resource path: \(path)")
            
            if let data = data(jsonFilePath: path) {
                do {
                    return try object.responseBuilder.createResponse(data)
                } catch {
                    throw error
                }
            }
        }
        
        throw URLError(.resourceUnavailable)
    }
    
}

