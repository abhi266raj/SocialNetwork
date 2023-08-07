# Social Network

## Requirement
 Xcode 15.0 beta or later
 iOS - 17.0 or later
 The code uses beta version of xcode and iOS for learning 
 Third party: none
 
## Architecutre - MVVM-C

- Different subproject
- Service - Networking code
- Model
- View
- ViewModel
- Main App Coordinator

## Flow

- Three coordinator one for each flow
- Each coordinator call related viewModel and view
- ViewModel make network call and interact with service
- Api detail are in ViewModel
- Network service are there
- Model are codable object with no logic
- View are swiftUI view
- Binding is via observable


