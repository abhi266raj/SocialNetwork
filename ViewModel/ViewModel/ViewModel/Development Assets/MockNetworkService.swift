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
    
    fileprivate func string(jsonFilePath:String) -> String? {
        if let jsonPath = bundle?.path(forResource: jsonFilePath, ofType: "json"),
           let item = try? String(contentsOfFile: jsonPath, encoding: .utf8) {
            return item
        }
        return nil
    }
    
    
    public func fetchUsing<T: NetworkObject>(_ object: T) async throws -> T.ResponseObject.ModelObject {
        let url = object.requestBuilder.createRequest().url
        if let path = url?.path {
            print(path)
            if let string = string(jsonFilePath: path) {
                do {
                    let data = try await convertJSONStringToData(jsonString: string)
                    return try object.responseBuilder.createResponse(data)
                } catch {
                    throw error
                }
                
            }
        }
        
        throw URLError(URLError.badURL)
    }
    
    private func convertJSONStringToData(jsonString: String) async throws -> Data {
        guard let jsonData = jsonString.data(using: .utf8) else {
            let description = NSLocalizedString("Invalid JSON format", comment: "JSON parsing error")
                throw NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: description])
        }
        return jsonData
    }
}

