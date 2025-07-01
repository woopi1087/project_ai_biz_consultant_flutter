import 'package:flutter/material.dart';
import 'package:project_ai_biz_consultant_flutter/pages/location/location_select_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF), // ✅ 배경색 통일
        elevation: 0, // ✅ 그림자 제거
        leading: const BackButton(color: Colors.black),
        title: const Text(
          '창업 컨설팅',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            _buildServiceTile(
              icon: Icons.place,
              iconColor: Colors.indigo,
              title: '입지 분석',
              subtitle: '좋은 자리는 고객을 불러옵니다.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationSelectPage()),
                );
              },
            ),
            _buildServiceTile(
              icon: Icons.business_center,
              iconColor: Colors.blue,
              title: '업종 추천',
              subtitle: '상권에 꼭 맞는 업종을 추천드려요.',
              onTap: () {
                _showComingSoonDialog(context);
              },
            ),
            _buildServiceTile(
              icon: Icons.analytics,
              iconColor: Colors.deepPurple,
              title: '매출 예측',
              subtitle: '매출 흐름을 미리 파악해볼 수 있어요.',
              onTap: () {
                _showComingSoonDialog(context);
              },
            ),
            _buildServiceTile(
              icon: Icons.support,
              iconColor: Colors.teal,
              title: '정부지원금 찾기',
              subtitle: '몰라서 못 받는 지원금, 함께 찾아드릴게요.',
              onTap: () {
                _showComingSoonDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        radius: 28,
        child: Icon(icon, color: iconColor, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF)),
      onTap: onTap,
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("준비 중이에요"),
        content: const Text("이 기능은 조금만 기다려주세요!\n곧 만나보실 수 있어요."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}
