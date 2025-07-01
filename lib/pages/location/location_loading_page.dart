import 'dart:async';
import 'package:flutter/material.dart';
import 'location_result_page.dart';

class LocationLoadingPage extends StatefulWidget {
  final String selectedAddress;

  const LocationLoadingPage({required this.selectedAddress, super.key});

  @override
  State<LocationLoadingPage> createState() => _LocationLoadingPageState();
}

class _LocationLoadingPageState extends State<LocationLoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LocationResultPage(address: widget.selectedAddress),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Color(0xFF4C78FF),
                ),
                const SizedBox(height: 32),
                const Text(
                  '입지를 분석 중입니다...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "선택한 위치: ${widget.selectedAddress}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
