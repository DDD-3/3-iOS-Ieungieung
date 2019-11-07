# 이응이응 iOS

**기기**

## 기술

- iOS 13
- Swift 5.1
- SwiftUI
- Combine

## 개발환경 설정

### 프로젝트 내려받기

1. 터미널을 켜고 프로젝트를 내려받을 디렉토리로 이동합니다.
2. `git clone https://github.com/DDD-3/3-iOS-Ieungieung.git` 명령어를 실행하여 프로젝트를 클론 받습니다.

### CocoaPods 설정

1. `sudo gem install cocoapods` 명령어를 실행하여 CocoaPods를 설치합니다.
2. `pod install` 명령어를 실행하여 프로젝트가 의존하는 라이브러리를 설치합니다.
3. `gigi.xcworkspace`를 열어 작업합니다.

### kakao SDK 설정

1. [다운로드 링크](https://developers.kakao.com/sdk/latest-ios-sdk)에서 iOS SDK를 다운로드합니다.
2. 프로젝트의 `Frameworks` 디렉토리에 `KakaoMessageTemplate.framework`, `KakaoCommon.framework`, `KakaoLink.framework` 프레임워크를 추가합니다.

## 기타

- 커밋 시 swiftformat이 동작합니다. 이를 무시하려면 `git commit --no-verify`를 통해 커밋하세요.