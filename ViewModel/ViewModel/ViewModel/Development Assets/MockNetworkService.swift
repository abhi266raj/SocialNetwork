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
    
    var jsonString: String = ""
    
    public init() {
        jsonString = string1
    }
    
    public func feedAPI() -> MockNetworkService {
        self.jsonString = string1
        return self
    }
    
    public func profileApi() -> MockNetworkService {
        self.jsonString = string2
        return self
    }
    
    public func detailApi() -> MockNetworkService {
        self.jsonString = string3
        return self
    }
    
    
    public func fetchUsing<T: NetworkObject>(_ object: T) async throws -> T.ResponseObject.ModelObject {
        do {
            let data = try await convertJSONStringToData(jsonString: jsonString)
            return try object.responseBuilder.createResponse(data)
        } catch {
            throw error
        }
    }
    
    func convertJSONStringToData(jsonString: String) async throws -> Data {
        guard let jsonData = jsonString.data(using: .utf8) else {
            let description = NSLocalizedString("Invalid JSON format", comment: "JSON parsing error")
                throw NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: description])
        }
        return jsonData
    }
}

let string1 =
"""
{
    "status": "success",
    "data": {
      "count": 4,
      "next": null,
      "previous": null,
      "results": [
        {
          "id": 1,
          "video_url": "https://stream.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00.m3u8",
          "likes": 10,
          "created_at": "2023-08-04T14:00:01.736647Z",
          "thumbnail_url": "https://image.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00/thumbnail.png",
          "user": "1"
        },
        {
          "id": 2,
          "video_url": "https://stream.mux.com/Nfg00Va6dpv01jn7EqYZW63ss7JbWhHxPaYPXLHZMOG98.m3u8",
          "likes": 5,
          "created_at": "2023-08-04T14:00:01.745897Z",
          "thumbnail_url": "https://image.mux.com/Nfg00Va6dpv01jn7EqYZW63ss7JbWhHxPaYPXLHZMOG98/thumbnail.png",
          "user": "2"
        },
        {
          "id": 3,
          "video_url": "https://stream.mux.com/DFjf8lfvLQalbg00pPeEUdhFwGEgtgEC0200QbHDHZAQT00.m3u8",
          "likes": 15,
          "created_at": "2023-08-04T14:00:01.762458Z",
          "thumbnail_url": "https://image.mux.com/DFjf8lfvLQalbg00pPeEUdhFwGEgtgEC0200QbHDHZAQT00/thumbnail.png",
          "user": "1"
        },
        {
          "id": 4,
          "video_url": "https://stream.mux.com/NqcirvarTf7KODnESgsK5Kl5usWbhWRtPdYNa01r6VMQ.m3u8",
          "likes": 20,
          "created_at": "2023-08-04T14:00:01.772596Z",
          "thumbnail_url": "https://image.mux.com/NqcirvarTf7KODnESgsK5Kl5usWbhWRtPdYNa01r6VMQ/thumbnail.png",
          "user": "2"
        }
      ]
    }
  }
"""

let string2 =
"""
{
  "status": "success",
  "data": {
    "id": 1,
    "video_url": "https://stream.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00.m3u8",
    "likes": 10,
    "created_at": "2023-08-04T14:00:01.736647Z",
    "thumbnail_url": "https://image.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00/thumbnail.png",
    "user": "1"
  }
}
"""

let string3 =
"""
{
  "status": "success",
  "data": {
    "id": "1",
    "name": "John Doe",
    "user_name": "john_doe",
    "email": "john@example.com",
    "profile_pic": "https://dummyimage.com/191x100.png/dddddd/000000&text=john_doe",
    "posts": [
      {
        "id": 1,
        "video_url": "https://stream.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00.m3u8",
        "likes": 10,
        "created_at": "2023-08-04T14:00:01.736647Z",
        "thumbnail_url": "https://image.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00/thumbnail.png",
        "user": "1"
      },
      {
        "id": 3,
        "video_url": "https://stream.mux.com/DFjf8lfvLQalbg00pPeEUdhFwGEgtgEC0200QbHDHZAQT00.m3u8",
        "likes": 15,
        "created_at": "2023-08-04T14:00:01.762458Z",
        "thumbnail_url": "https://image.mux.com/DFjf8lfvLQalbg00pPeEUdhFwGEgtgEC0200QbHDHZAQT00/thumbnail.png",
        "user": "1"
      }
    ]
  }
}
"""


