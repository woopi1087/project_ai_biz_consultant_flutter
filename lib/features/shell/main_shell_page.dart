import 'package:flutter/material.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _currentIndex = 0;

  // 각 탭에 보여줄 껍데기 내용
  final List<Widget> _pages = const [
    Center(child: Text("📄 샘플 탭 1", style: TextStyle(fontSize: 24))),
    Center(child: Text("🧪 샘플 탭 2", style: TextStyle(fontSize: 24))),
    Center(child: Text("⚙️ 샘플 탭 3", style: TextStyle(fontSize: 24))),
  ];

  final List<String> _titles = ['탭 1', '탭 2', '탭 3'];

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
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '탭1'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: '탭2'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '탭3'),
        ],
      ),
    );
  }
}
