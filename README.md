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
- DI


## Design Pattern 
### In coordianator
- Abstract factory for coordiantor which create view and view Model pair
- DI container struct contains various DI elements
- Cosntruction role, providing Depedncy is role of factory. 

## Flow

- Three coordinator one for each flow
- Each coordinator call related viewModel and view
- ViewModel make network call and interact with service
- Api detail are in ViewModel
- Network service are there
- Model are codable object with no logic
- View are swiftUI view
- Binding is via observable

## Perfomance
- Image Cached via CachedAsyncImage 
- Video perfomance via - Showing image thumb while video is loading to improve feel
- Video not cahced but only image. 
- Network response not cached as they change.

## Error Case handling
- Error in network call and retry are handled via FirstApiView and ApiCallLodable protocol and APIResultViewModel
- FirstApiView manages state like loading, error and retry and view for same
- APIResultViewModel maintian error, state of network call etc
- ApiCallLodable protocol declares that api call will be made.

## Themes
- Theme struct for changing color

## To do
- Support for dark mode

## Unfixed things
- Gitignore is not setup
- Naming correctness
- MeaningFul commit message and proper git workflow
- Linting
- UITesting
- Unit Testing
- Visual Diff Testing

## System Diagram App Launch Flow

```mermaid
graph TD;
    style App fill:#F9F9F9, stroke:#333, stroke-width:1px;
    style Views fill:#E6E6E6, stroke:#333, stroke-width:1px;
    style Models fill:#F0E5DE, stroke:#333, stroke-width:1px;
    style ViewModels fill:#FFD7A5, stroke:#333, stroke-width:1px;
    style Coordinators fill:#FFAC81, stroke:#333, stroke-width:1px;
    style AbstractFactory fill:#C7CEEA, stroke:#333, stroke-width:1px;
    style Dependcy fill:#A0CED9, stroke:#333, stroke-width:1px;
    
    subgraph App

        subgraph legends
        A[ ] --> M(DirectInit)
        B[ ] -.-> DependentItem
        end
        
        subgraph Views
            feedView[View: Feed]
            detailView[View: Detail]
            profileView[View: Profile]
            apiStateView[View: FirstApiState]
            imageView
            VideoView
        end

        subgraph Models
            feedModel[Model: Feed]
            detailModel[Model: Detail]
            profileModel[Model: Profile]
        end

        subgraph ViewModels
            apiStateViewModel[ViewModel: FirstApiState]
            feedViewModel[ViewModel: Feed]
            detailViewModel[ViewModel: Detail]
            profileViewModel[ViewModel: Profile]
        end

        subgraph Coordinators
            feedCoordinator[Coordinator: Feed]
            detailCoordinator[Coordinator: Detail]
            profileCoordinator[Coordinator: Profile]
        end

        subgraph AbstractFactory
            feedFactory[Factory: Feed]
            detailFactory[Factory: Detail]
            profileFactory[Factory: Profile]
        end

        subgraph Dependcy
            Networking[Networking]
        end

        ApSingleton[AppLaunch] --> Dependcy
        ApSingleton --> Coordinators

        apiStateView --> apiStateViewModel 

        ViewModels --> Models

        AbstractFactory --> ViewModels
        AbstractFactory --> Views

        Coordinators --> AbstractFactory

        feedCoordinator --> detailCoordinator
        detailCoordinator --> profileCoordinator
        profileCoordinator --> detailCoordinator

        feedView & profileView & detailView -->imageView
        detailView --> VideoView

        feedViewModel & detailViewModel & profileViewModel --> apiStateViewModel
       
        Coordinators .-> Dependcy
        AbstractFactory .-> Dependcy 
        Views .-> ViewModels
        ViewModels .-> Networking
      
    
    end
```
