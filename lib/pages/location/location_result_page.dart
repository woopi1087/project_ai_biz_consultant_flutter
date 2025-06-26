import 'package:flutter/material.dart';

class LocationResultPage extends StatelessWidget {
  final String address;

  const LocationResultPage({required this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("분석 결과")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍 분석 지역: $address",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("예상 매출"),
                subtitle: const Text("월 580만원 ~ 750만원"),
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("경쟁도"),
                subtitle: const Text("중간 (경쟁 점수: 64점)"),
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("추천 업종"),
                subtitle: const Text("테이크아웃 커피, 편의점"),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("처음으로 돌아가기"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
