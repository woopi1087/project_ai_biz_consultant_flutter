import 'package:flutter/material.dart';
// import 'select_region_page.dart'; // 다음 페이지 있으면 연결할 준비

class LocationAnalysisStartPage extends StatelessWidget {
  const LocationAnalysisStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('입지 분석 시작'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AI 기반 입지 분석",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "선택한 지역의 유동인구, 업종 경쟁도 등을 바탕으로\n가장 유리한 입지를 분석해드립니다.",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 지역 선택 페이지 연결
                  // Navigator.push(
                  //   context
                  //   MaterialPageRoute(
                  //     builder: (_) => const SelectRegionPage(), // 다음 페이지 연결용
                  //   ),
                  // );
                },
                child: const Text("입지 분석 시작하기"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
