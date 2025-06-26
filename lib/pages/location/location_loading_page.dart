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
          builder: (_) =>
              LocationResultPage(address: widget.selectedAddress),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(strokeWidth: 5),
              const SizedBox(height: 24),
              const Text('입지를 분석 중입니다...',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Text("선택한 위치: ${widget.selectedAddress}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
