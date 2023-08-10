//
//  ModelTests.swift
//  ModelTests
//
//  Created by Abhiraj on 05/08/23.
//

import XCTest
@testable import Model

class CodableTests: XCTestCase {

    func testFeedResponseDecode() throws {
        let jsonData = Data(homeJson.utf8)
        let decoder = JSONDecoder()
        let feedResponse = try decoder.decode(FeedResponse.self, from: jsonData)
        XCTAssertNotNil(feedResponse)
    }

    func testPostDetailModelDecode() throws {
        let jsonData = Data(detailJson.utf8)
        let decoder = JSONDecoder()
        let postDetailModel = try decoder.decode(PostDetailModel.self, from: jsonData)
        XCTAssertNotNil(postDetailModel)
    }

    func testProfileDetailModelDecode() throws {
        let jsonData = Data(profileJson.utf8)
        let decoder = JSONDecoder()
        let profileDetailModel = try decoder.decode(ProfileDetailModel.self, from: jsonData)
        XCTAssertNotNil(profileDetailModel)
    }

    func testPostEncodeDecode() throws {
        let jsonData = Data(detailJson.utf8)
        let decoder = JSONDecoder()
        let postDetailModel = try decoder.decode(PostDetailModel.self, from: jsonData)
        
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(postDetailModel.data)
        let decodedPost = try decoder.decode(Post.self, from: encodedData)
        
        XCTAssertEqual(postDetailModel.data.id, decodedPost.id)
        XCTAssertEqual(postDetailModel.data.videoURL, decodedPost.videoURL)
        XCTAssertEqual(postDetailModel.data.likes, decodedPost.likes)
        XCTAssertEqual(postDetailModel.data.thumbnailURL, decodedPost.thumbnailURL)
        XCTAssertEqual(postDetailModel.data.user, decodedPost.user)
    }
    
    func testInvalidFeedResponseDecode() throws {
            let invalidJsonData = Data("invalidJsonData".utf8)
            let decoder = JSONDecoder()
            XCTAssertThrowsError(try decoder.decode(FeedResponse.self, from: invalidJsonData))
        }

        func testInvalidPostDetailModelDecode() throws {
            let invalidJsonData = Data("invalidJsonData".utf8)
            let decoder = JSONDecoder()
            XCTAssertThrowsError(try decoder.decode(PostDetailModel.self, from: invalidJsonData))
        }

        func testInvalidProfileDetailModelDecode() throws {
            let invalidJsonData = Data("invalidJsonData".utf8)
            let decoder = JSONDecoder()
            XCTAssertThrowsError(try decoder.decode(ProfileDetailModel.self, from: invalidJsonData))
        }
}

extension CodableTests {
    
    var homeJson: String {
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
    }

    var detailJson: String {
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
    }

    var profileJson: String {
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
    }



}
