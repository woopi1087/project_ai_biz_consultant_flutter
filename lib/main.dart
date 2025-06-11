import 'package:flutter/material.dart';
import 'package:project_ai_biz_consultant_flutter/features/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI 비즈 컨설턴트',
      // 전역 테마 설정 (기본 색상 등)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 첫 진입 화면: 스플래시
      home: const SplashPage(),
    );
  }
}
