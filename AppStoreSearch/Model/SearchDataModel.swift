//
//  SearchDataModel.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/18.
//

import Foundation

struct SearchData: Codable {
    let resultCount: Int
    let results: [SearchDataModel]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}

struct SearchDataModel: Codable {
    /// 지원 기기
    let supportedDevices: [String]
    /// 앱 소개 이미지
    let screenshotUrls: [String]
    /// 앱 썸네일
    let artworkUrl512: String
    /// 패치노트
    let releaseNotes: String?
    /// 앱 소개
    let description: String
    /// 앱 이름
    let trackName: String
    /// 앱 제공자
    let sellerName: String
    /// 앱 종류
    let genres: [String]
    /// 앱 버전
    let version: String
    /// 앱 사용 연령
    let contentAdvisoryRating: String
    /// 앱 가격
    let price: Double?
    /// 앱 별점
    let averageUserRating: Double
    /// 앱 평가
    let userRatingCountForCurrentVersion: Int
    /// 앱 콘텐츠 순위
    let trackContentRating: String?
    /// 이미지 URL 전부 모은 곳
    var image: [String] {
        var images = screenshotUrls
        images.insert(artworkUrl512, at: 0)
        return images
    }

    enum CodingKeys: String, CodingKey {
        case supportedDevices = "supportedDevices"
        case screenshotUrls = "screenshotUrls"
        case artworkUrl512 = "artworkUrl512"
        case releaseNotes = "releaseNotes"
        case description = "description"
        case trackName = "trackName"
        case sellerName = "sellerName"
        case genres = "genres"
        case version = "version"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case price = "price"
        case averageUserRating = "averageUserRating"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
        case trackContentRating = "trackContentRating"
    }
}
