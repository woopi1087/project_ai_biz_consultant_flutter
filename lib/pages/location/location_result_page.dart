import 'package:flutter/material.dart';

class LocationResultPage extends StatelessWidget {
  final String address;

  const LocationResultPage({required this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF),
        elevation: 0,
        title: const Text(
          "입지 분석 결과",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 지역 정보
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.redAccent),
                        const SizedBox(width: 8),
                        Text(
                          "분석 지역: $address",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 지표 리스트
                    _buildInfoItem(Icons.monetization_on, '예상 매출', '580~750만원'),
                    _buildInfoItem(Icons.bolt, '경쟁도', '중간 (64점)'),
                    _buildInfoItem(Icons.storefront, '추천 업종', '테이크아웃 커피, 편의점'),
                    _buildInfoItem(Icons.people, '유동 인구', '일 평균 13,500명'),
                    _buildInfoItem(Icons.store, '유사 업종 수', '500m 내 12곳'),
                    _buildInfoItem(Icons.access_time, '피크 타임', '오후 12시 ~ 2시'),
                    _buildInfoItem(Icons.money, '임대료 수준', '월 125만원 (3.3㎡ 기준)'),
                    _buildInfoItem(Icons.policy, '지원 정책', '서울형 임대료 지원 대상'),
                  ],
                ),
              ),
            ),

            // 하단 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("처음으로 돌아가기"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Divider(height: 24),
      ],
    );
  }
}
