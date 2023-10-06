# HanSang
[ 내일배움캠프 iOS트랙 ] — 12~13주차 심화 과정 팀과제 / CoreData를 활용한 앱 만들기

<br><br>

## 📆 프로젝트 기간
- 2023/09/24 ~ 2023/10/06 (추석 연휴 포함하여 2주, 14일간)

<br>

## ✅ 구현 기능
- **필수 구현기능**
  - [x] 사용자 로그인 기능
  - [x] 레시피 추가 기능
  - [x] 레시피 검색 기능
  - [x] 스톱워치 기능
  - [x] 타이머 기능
  - [x] 북마크 기능

- **선택 구현기능**
  - [x] 디자인 패턴
  - [x] 각각의 UI 개선
 
<br>

## 🛠️ 사용한 기술 스택
<img src="https://img.shields.io/badge/xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white"> <img src="https://img.shields.io/badge/swift-F05138?style=for-the-badge&logo=swift&logoColor=white">

<br>

## ⚡️ 사용한 라이브러리와 그 이유
1. [SnapKit](https://github.com/SnapKit/SnapKit) :: ` Auto Layout `을 쉽게 설정하기 위해 사용
2. CoreData :: ` Data ` 를 일관성 있게 다루기 위해 사용

<br>

## 📚 HanSang 앱 파일 구조
![](https://github.com/tjddnjs549/HanSang/assets/53863005/6567f609-db63-444a-a883-50538e120051)

<br>

## 🧐 앱 실행 및 사용 방법
![](https://github.com/tjddnjs549/HanSang/assets/53863005/8c48b2b6-3eb9-4c2c-9901-a8ca67d265c4)


<br>

## 💥 Troubles Shooting
- 하나의 ViewController에 세개의 view를 넣고 hidden 처리를 통해 페이징되도록 구현했는데 view 안의 cell의 button이 클릭되었을때 ViewController에 present나 dismiss 행동을 해야했음
  ```
  NotificationCenter를 사용하여 present 해야하는 ViewController를 object로 추가하여 post해주고 Create ViewController에 addObserver 추가하여 해결함
  ```
- 키보드가 나타날 때 뷰의 일부가 가리는 문제
  ```
  NotificationCenter 옵저버를 통해 키보드가 나타나거나 사라질 때 뷰를 이동시키는 로직 추가
  ```
- 북마크 버튼 클릭 시 다른 셀에 북마크 처리되는 문제
  ```
  셀이 재사용 될 때 데이터 기반 북마크 상태에 따른 이미지 설정
  ```
- searchbar가 스크롤 할 때 안보이는 문제
  ```
  기본적으로 hidesSearchBarWhenScrolling 속성은 true로 설정되어 있으며, 사용자가 스크롤하면 검색 바가 자동으로 숨겨짐. 검색 바를 스크롤과 관계없이 항상 표시하려면 hidesSearchBarWhenScrolling 속성을 false로 설정하면 검색 바가 항상 화면 상단에 표시됨
  ```
