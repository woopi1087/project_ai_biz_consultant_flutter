import 'package:flutter/material.dart';
import '../home/home_page.dart'; // HomePage 경로 맞게 수정하시오

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 페이드 인/아웃 애니메이션 설정
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(); // 페이드 인

    // 800ms 인 + 600ms 유지 후 = 1400ms
    Future.delayed(const Duration(milliseconds: 1400), () async {
      await _controller.reverse(); // 페이드 아웃
      await Future.delayed(const Duration(milliseconds: 100)); // 공백 제거용 딜레이

      // 👉 바로 홈으로 라우팅
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/splash_logo.png', // pubspec.yaml에 등록 필요
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
