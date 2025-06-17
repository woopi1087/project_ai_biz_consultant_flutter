import 'package:flutter/material.dart';
import 'package:project_ai_biz_consultant_flutter/features/location_analysis/location_analysis_start_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEF8), // ← 배경 색상 추가
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "오늘도 화이팅입니다!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              const Text(
                "컨설팅 메뉴",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildConsultCard(
                      context,
                      icon: Icons.place,
                      title: '입지 분석',
                      onTap: () {
                        // TODO: 입지 분석 페이지 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LocationAnalysisStartPage(),
                          ),
                        );
                      },
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.business_center,
                      title: '업종 추천',
                      onTap: () {
                        // TODO: 업종 추천 페이지 이동
                      },
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.analytics,
                      title: '매출 예측',
                      onTap: () {},
                    ),
                    _buildConsultCard(
                      context,
                      icon: Icons.support,
                      title: '정부지원금 찾기',
                      onTap: () {},
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
