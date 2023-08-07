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
    
    public var state = ApiState.initial
    
    var fetchData:(()->Void) = {}
    
    public enum ApiState {
        case initial
        case loading
        case success
        case error(String)
    }
    
    public func fetchDataIfNeeded() {
        switch state {
            case .initial, .error:
                self.fetchData()
            default:
                break
        }
    }

    func getResult<T>(apiObject: JsonApiObject<T>, networkService: NetworkService) async throws -> T {
        state = .loading
        do  {
            let response = try await networkService.fetchUsing(apiObject)
            defer {
                state = .success
            }
            return response
        }catch let (error) {
            state = .error(error.localizedDescription)
            throw error
        }
    }
    
    
    
    
}
