//
//  KakaoSearchByCategoryResponse.swift
//  gigi
//
//  Created by Presto on 2019/11/10.
//  Copyright © 2019 ieungieung. All rights reserved.
//

import Foundation

/// `카테고리로 장소 검색` 응답 모델.
struct KakaoSearchByCategoryResponse: Decodable {

  /// 응답 메타 데이터.
  struct Meta: Decodable {

    /// 질의어의 지역 및 키워드 분석 정보.
    struct SameName: Decodable {

      /// 질의어에서 인식된 지역의 리스트.
      let region: [String]

      /// 질의어에서 지역 정보를 제외한 키워드.
      let keyword: String

      /// 인식된 지역 리스트 중 현재 검색에 사용된 지역 정보.
      let selectedRegion: String

      private enum CodingKeys: String, CodingKey {

        case region

        case keyword

        case selectedRegion = "selected_region"
      }
    }

    /// 검색어에 검색된 문서 수.
    let totalCount: Int

    /// 현재 페이지가 마지막 페이지인지 여부.
    let isEnd: Bool

    /// `totalCount` 중에 노출 가능한 문서 수. 최대 45.
    let pageableCount: Int

    /// 질의어의 지역 및 키워드 분석 정보.
    let sameName: SameName?

    private enum CodingKeys: String, CodingKey {

      case totalCount = "total_count"

      case isEnd = "is_end"

      case pageableCount = "pageable_count"

      case sameName = "same_name"
    }
  }

  /// 응답 결과 문서.
  struct Document: Decodable {

    /// 장소 ID.
    let id: String

    /// 장소명 및 업체명.
    let placeName: String

    /// 카테고리 이름.
    let categoryName: String

    /// 중요 카테고리만 그룹핑한 카테고리 그룹 코드.
    let categoryGroupCode: KakaoPlaceCategory

    /// 중요 카테고리만 그룹핑한 카테고리 그룹 이름.
    let categoryGroupName: String

    /// 전화번호.
    let phone: String

    /// 전체 지번 주소.
    let addressName: String

    /// 전체 도로명 주소.
    let roadAddressName: String

    /// X 좌표값 혹은 longitude.
    let x: String

    /// Y 좌표값 혹은 latitude.
    let y: String

    /// 장소 상세 페이지 URL.
    let placeURL: URL

    /// 중심좌표까지의 거리(x, y 파라미터를 준 경우에만 존재), 단위 meter.
    let distance: Int

    private enum CodingKeys: String, CodingKey {

      case id

      case placeName = "place_name"

      case categoryName = "category_name"

      case categoryGroupCode = "category_group_code"

      case categoryGroupName = "category_group_name"

      case phone

      case addressName = "address_name"

      case roadAddressName = "road_address_name"

      case x

      case y

      case placeURL = "place_url"

      case distance
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decode(String.self, forKey: .id)
      placeName = try container.decode(String.self, forKey: .placeName)
      categoryName = try container.decode(String.self, forKey: .categoryName)
      let categoryGroupCodeString = try container.decode(String.self, forKey: .categoryGroupCode)
      categoryGroupCode = KakaoPlaceCategory(rawValue: categoryGroupCodeString)!
      categoryGroupName = try container.decode(String.self, forKey: .categoryGroupName)
      phone = try container.decode(String.self, forKey: .phone)
      addressName = try container.decode(String.self, forKey: .addressName)
      roadAddressName = try container.decode(String.self, forKey: .roadAddressName)
      x = try container.decode(String.self, forKey: .x)
      y = try container.decode(String.self, forKey: .y)
      let placeURLString = try container.decode(String.self, forKey: .placeURL)
      placeURL = URL(string: placeURLString)!
      let distanceString = try container.decode(String.self, forKey: .distance)
      distance = Int(distanceString) ?? 0
    }
  }

  /// 응답 메타 데이터.
  let meta: Meta

  /// 응답 결과 문서 리스트.
  let documents: [Document]
}
