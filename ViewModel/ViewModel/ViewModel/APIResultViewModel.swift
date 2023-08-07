//
//  APIStateViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 07/08/23.
//

import Observation

@Observable public class APIStateViewModel {
    
    enum state {
        case initial
        case loading
        case success
        case error
    }
    
    
}
