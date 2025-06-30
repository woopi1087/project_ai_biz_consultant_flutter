import 'package:flutter/material.dart';
import 'package:project_ai_biz_consultant_flutter/pages/location/location_select_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4EAF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                '안녕하세요, 사장님!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'AI가 함께하는 창업 컨설팅 도우미입니다',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildConsultCard(
                      context,
                      icon: Icons.place,
                      title: '입지 분석',
                      subtitle: '좋은 자리는 고객을 불러옵니다.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LocationSelectPage()),
                        );
                      },
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.business_center,
                      title: '업종 추천',
                      subtitle: '상권에 꼭 맞는 업종을 추천드려요.',
                      onTap: () {
                        _showComingSoonDialog(context);
                      },
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.analytics,
                      title: '매출 예측',
                      subtitle: '매출 흐름을 미리 파악해볼 수 있어요.',
                      onTap: () {
                        _showComingSoonDialog(context);
                      },
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.support,
                      title: '정부지원금 찾기',
                      subtitle: '몰라서 못 받는 지원금, 함께 찾아드릴게요.',
                      onTap: () {
                        _showComingSoonDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsultCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFF9FAFF), // 부드러운 카드 배경
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 36, color: Color(0xFF4C78FF)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        )),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
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
