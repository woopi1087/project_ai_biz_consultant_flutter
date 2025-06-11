# project_ai_biz_consultant_flutter
A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



---
# 시작
flutter run

# 디바이스 연결 확인
adb devices

# flutter 설치 확인
flutter doctor

# flutter 빌드 (디버스 APK)
flutter build apk --debug

# flutter 빋르 (릴리즈 APK)
flutter build apk --release

# flutter 실행 (디바이스 연결 후에 하면, 바로 디바이스에 설치 및 확인 가능)
flutter run



my_app/
├── android/             # 안드로이드 플랫폼용 코드 (Kotlin 또는 Java)
├── ios/                 # iOS 플랫폼용 코드 (Swift 또는 Objective-C)
├── lib/                 # 💥 Dart 코드의 본진 (앱 로직의 핵심)
│   └── main.dart        # 앱의 진입점
├── test/                # 테스트 코드
├── web/                 # 웹 빌드를 위한 디렉토리 (web 지원할 때 생성됨)
├── build/               # 빌드 결과물 (자동 생성, 무시 가능)
├── pubspec.yaml         # 📦 의존성, asset 설정 등 프로젝트 메타정보
├── pubspec.lock         # 실제로 설치된 패키지 버전 고정 정보
└── README.md            # 설명 파일


lib/
├── main.dart                   # 앱 진입점
├── app.dart                    # MaterialApp, 라우팅 등 설정
├── core/                       # 공통 유틸, 상수, 테마 등
│   ├── theme/
│   ├── constants/
│   └── utils/
├── models/                     # 데이터 모델 클래스 (DTO)
├── services/                   # API, DB, SharedPreferences 등
├── views/                      # 화면 UI 코드 (Page, Screen 등)
│   └── home/
│       ├── home_page.dart
│       └── home_view_model.dart
├── widgets/                    # 재사용 가능한 위젯 모음
└── routes/                     # 라우팅 관련 설정





# 📦 Flutter 프로젝트 기본 구조 & 모듈화 가이드

## 🏗️ 기본 디렉토리 구조

my_app/
├── android/ # Android 플랫폼 코드 (Kotlin/Java)
├── ios/ # iOS 플랫폼 코드 (Swift/Objective-C)
├── lib/ # 💥 앱 로직과 UI 코드의 본진
│ └── main.dart # 앱 진입점
├── test/ # 테스트 코드
├── web/ # 웹 앱 지원 (선택적)
├── build/ # 빌드 결과물 (자동 생성, 무시 가능)
├── pubspec.yaml # 프로젝트 의존성 및 메타 정보
├── pubspec.lock # 실제 설치된 패키지 버전 고정
└── README.md # 프로젝트 설명


## 🧱 권장 모듈화 구조 (Feature-based)

lib/
├── main.dart # 앱 진입점
├── app.dart # MaterialApp, 라우트 설정 등
├── core/ # 공통 요소
│ ├── constants/ # 상수 (색상, 폰트, 문자열 등)
│ ├── theme/ # 테마 및 스타일
│ └── utils/ # 유틸 함수 및 확장 함수
├── models/ # 데이터 모델 (DTO 등)
├── services/ # API, 로컬 저장소 등 비즈니스 로직
├── routes/ # 라우팅 관련 설정
├── widgets/ # 재사용 가능한 위젯 모음
└── features/ # 기능 단위 모듈
├── auth/
│ ├── login_page.dart
│ ├── login_view_model.dart
│ └── auth_service.dart
├── home/
│ ├── home_page.dart
│ ├── home_view_model.dart
│ └── home_service.dart
└── profile/
├── profile_page.dart
├── profile_view_model.dart
└── profile_service.dart


## ✅ 상태관리/패키지 구성 예시 (Provider 기반)

- ViewModel: `ChangeNotifier` 사용
- View: `Consumer`, `Selector` 등으로 상태 구독
- 전역 주입: `MultiProvider` 사용

예시 구조:
lib/
└── features/
└── counter/
├── counter_page.dart
├── counter_view_model.dart
└── counter_provider.dart


## 🚀 추천 패키지

- 상태관리: `provider`, `riverpod`, `flutter_bloc`
- 네트워크: `dio`
- 라우팅: `go_router`, `auto_route`
- 저장소: `shared_preferences`, `hive`



## 흐름

- 앱 진입
main.dart
  ↓
SplashPage          ← 앱 로딩 화면
  ↓
MainShellPage       ← 하단 내비바 + 탭 구조 (고정된 뼈대)
  ├─ HomeTab()      ← 내비 탭 1번
  ├─ AiTab()        ← 내비 탭 2번
  └─ SettingsTab()  ← 내비 탭 3번