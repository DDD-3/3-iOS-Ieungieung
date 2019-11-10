//
//  KakaoPlaceCategory.swift
//  gigi
//
//  Created by Presto on 2019/11/10.
//  Copyright © 2019 ieungieung. All rights reserved.
//

/// kakao REST API의 장소 카테고리 그룹 코드.
///
/// 원시 값은 kakao REST API가 제공하는 그룹 코드를 의미한다.
enum KakaoPlaceCategory: String {

  /// 대형마트.
  case mart = "MT1"

  /// 편의점.
  case convenienceStore = "CS2"

  /// 어린이집, 유치원.
  case kindergarten = "PS3"

  /// 학교.
  case school = "SC4"

  /// 학원.
  case institute = "AC5"

  /// 주차장.
  case parkingLot = "PK6"

  /// 주유소, 충전소.
  case oilStation = "OL7"

  /// 지하철역.
  case subwayStation = "SW8"

  /// 은행.
  case bank = "BK9"

  /// 문화시설.
  case culturalFacility = "CT1"

  /// 중개업소.
  case brokerageAgency = "AG2"

  /// 공공기관.
  case publicInstitution = "PO3"

  /// 관광명소.
  case attraction = "AT4"

  /// 숙박.
  case accomodation = "AD5"

  /// 음식점.
  case restaurant = "FD6"

  /// 카페.
  case cafe = "CE7"

  /// 병원.
  case hospital = "HP8"

  /// 약국.
  case pharmacy = "PM9"
}
