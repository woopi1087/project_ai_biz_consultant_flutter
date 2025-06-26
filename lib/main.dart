import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:project_ai_biz_consultant_flutter/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(); // ✅ 환경변수 로드

  final clientId = dotenv.env['NAVER_CLIENT_ID'];
  if (clientId == null) {
    throw Exception('NAVER_CLIENT_ID가 .env에 없음');
  }

  await FlutterNaverMap().init(
    clientId: clientId,
    onAuthFailed: (ex) => print('네이버 지도 인증 실패: $ex'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI 비즈 컨설턴트',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
