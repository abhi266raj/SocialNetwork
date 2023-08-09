//
//  APIStateViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 07/08/23.
//

import Observation
import Service


public protocol ApiCallLodable {
    var firstApiViewModel: APIResultViewModel {get}
}

@Observable public class APIResultViewModel {
    
    @MainActor public var state = ApiState.initial
    
    var fetchData:(()->Void) = {}
    
    public enum ApiState {
        case initial
        case loading
        case success
        case error(String)
    }
    
    @MainActor public func fetchDataIfNeeded() {
        switch state {
        case .initial, .error:
                self.fetchData()
            default:
                break
        }
    }

    @MainActor func getResult<T>(apiObject: JsonApiObject<T>, networkService: NetworkService) async throws -> T {
        state = .loading
        do  {
            let response = try await networkService.fetchUsing(apiObject)
            defer {
                state = .success
            }
            return response
        }catch let (error) {
            print(error.localizedDescription)
            state = .error(error.localizedDescription)
            print(error.localizedDescription.description)
            throw error
        }
    }
    
    
    
    
}
