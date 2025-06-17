import 'package:flutter/material.dart';
import 'package:project_ai_biz_consultant_flutter/features/home/home_tab.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _currentIndex = 0;

  // 각 탭에 보여줄 껍데기 내용
  final List<Widget> _pages = const [
    HomeTab(), // ← 기존 Center에서 홈탭으로 교체
    Center(child: Text("🧪 컨설팅", style: TextStyle(fontSize: 24))),
    Center(child: Text("🧪 분석", style: TextStyle(fontSize: 24))),
    Center(child: Text("🧪 알림", style: TextStyle(fontSize: 24))),
    Center(child: Text("⚙️ 내 정보", style: TextStyle(fontSize: 24))),
  ];

  final List<String> _titles = ['홈', '컨설팅', '분석', '알림', '내 정보'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // 또는 약간 톤 다운된 색
        selectedItemColor: Colors.deepOrangeAccent, // 강조 색
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: '컨설팅'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '분석'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
