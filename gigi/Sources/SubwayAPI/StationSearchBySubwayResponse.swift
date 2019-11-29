//
//  StationSearchBySubwayResponse.swift
//  gigi
//
//  Created by BLU on 28/11/2019.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import Foundation

/// 서울특별시 노선별 지하철역 정보.
///
/// `지하철 역 검색` 응답 모델.
struct StationSearchBySubwayResponse: Decodable {
  /// 지하철 역 정보 데이터.
  struct SubwayLineInfo: Decodable {
    /// 응답 결과 데이터.
    struct Result: Decodable {
      /// 응답 결과 코드.
      let code: String

      /// 응답 결과 메시지.
      let message: String

      private enum CodingKeys: String, CodingKey {
        case code = "CODE"

        case message = "MESSAGE"
      }
    }

    /// 지하철 역 데이터.
    struct Station: Decodable {
      /// 지하철 역 코드.
      let code: String

      /// 지하철 역 명.
      let name: String

      /// 지하철 역 명(영문).
      let englishName: String

      /// 지하철 호선.
      let subwayLine: String

      /// 외부 코드.
      let externalCode: String

      private enum CodingKeys: String, CodingKey {
        case code = "STATION_CD"

        case name = "STATION_NM"

        case englishName = "STATION_NM_ENG"

        case subwayLine = "LINE_NUM"

        case externalCode = "FR_CODE"
      }
    }

    /// 총 데이터 건수.
    let totalCount: Int

    /// 응답 결과 데이터.
    let result: Result

    /// 지하철 역 리스트.
    let stations: [Station]

    private enum CodingKeys: String, CodingKey {
      case totalCount = "list_total_count"

      case result = "RESULT"

      case stations = "row"
    }
  }

  /// 지하철 역 정보.
  let subwayLineInfo: SubwayLineInfo

  private enum CodingKeys: String, CodingKey {
    case subwayLineInfo = "SearchSTNBySubwayLineInfo"
  }
}
