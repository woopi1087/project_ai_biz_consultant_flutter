import 'package:flutter/material.dart';

// 초기화 로직, 데이터 검사, 조건 분기 수행, 상태 판단, 라우팅 처리 등 핵심 동작 수행
class SplashViewModel {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // 로딩 시간 조정 가능

    Navigator.pushReplacementNamed(context, '/home'); // 테스트용으로 일단 홈 고정
  }
}
