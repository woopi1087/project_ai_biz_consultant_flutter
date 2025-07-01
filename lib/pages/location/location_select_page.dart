import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_ai_biz_consultant_flutter/pages/location/location_loading_page.dart';

class LocationSelectPage extends StatefulWidget {
  const LocationSelectPage({super.key});

  @override
  State<LocationSelectPage> createState() => _LocationSelectPageState();
}

class _LocationSelectPageState extends State<LocationSelectPage> {
  NaverMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  String? _currentMarkerId;
  String? _currentPolygonId;

  final clientId = dotenv.env['NAVER_CLIENT_ID'];
  final clientSecret = dotenv.env['NAVER_CLIENT_SECRET'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addLocationWithBoundary('연남동', const NLatLng(37.5610, 126.9258));
    });
  }

  Future<void> _addLocationWithBoundary(String locationName, NLatLng position) async {
    if (_mapController == null) return;
    await _clearOverlays();
    await _addMarker(locationName, position);
    await _addBoundaryPolygon(locationName, position);
    await _moveCamera(position);
  }

  Future<void> _clearOverlays() async {
    if (_mapController == null) return;
    await _mapController?.clearOverlays();
    _currentMarkerId = null;
    _currentPolygonId = null;
  }

  Future<void> _addMarker(String locationName, NLatLng position) async {
    final marker = NMarker(id: 'location_marker', position: position);
    marker.setCaption(NOverlayCaption(text: locationName));
    await _mapController?.addOverlay(marker);
    _currentMarkerId = 'location_marker';
  }

  Future<void> _addBoundaryPolygon(String locationName, NLatLng centerPosition) async {
    try {
      final boundaryCoords = await _getBoundaryCoordinates(locationName, centerPosition);
      if (boundaryCoords.isNotEmpty) {
        final polygon = NPolygonOverlay(
          id: 'boundary_polygon',
          coords: boundaryCoords,
          color: Colors.blue.withOpacity(0.3),
          outlineColor: Colors.blue,
          outlineWidth: 2,
        );
        await _mapController?.addOverlay(polygon);
        _currentPolygonId = 'boundary_polygon';
      }
    } catch (_) {
      await _addCircularBoundary(centerPosition);
    }
  }

  Future<List<NLatLng>> _getBoundaryCoordinates(String name, NLatLng center) async {
    final Map<String, List<NLatLng>> boundaries = {
      '연남동': [
        const NLatLng(37.5650, 126.9200),
        const NLatLng(37.5680, 126.9280),
        const NLatLng(37.5620, 126.9320),
        const NLatLng(37.5580, 126.9280),
        const NLatLng(37.5570, 126.9220),
        const NLatLng(37.5620, 126.9180),
      ],
    };
    for (final key in boundaries.keys) {
      if (key.contains(name) || name.contains(key)) {
        return boundaries[key]!;
      }
    }
    return [];
  }

  Future<void> _addCircularBoundary(NLatLng center) async {
    final circle = NCircleOverlay(
      id: 'boundary_circle',
      center: center,
      radius: 800,
      color: Colors.green.withOpacity(0.2),
      outlineColor: Colors.green,
      outlineWidth: 2,
    );
    await _mapController?.addOverlay(circle);
    _currentPolygonId = 'boundary_circle';
  }

  Future<void> _moveCamera(NLatLng position) async {
    await _mapController?.updateCamera(
      NCameraUpdate.scrollAndZoomTo(target: position, zoom: 13.5),
    );
  }

  Future<NLatLng?> _searchLocationWithGeocoding(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=$query'),
        headers: {
          'X-NCP-APIGW-API-KEY-ID': clientId ?? '',
          'X-NCP-APIGW-API-KEY': clientSecret ?? '',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final addresses = data['addresses'] as List;
        if (addresses.isNotEmpty) {
          final first = addresses[0];
          final lat = double.parse(first['y']);
          final lng = double.parse(first['x']);
          return NLatLng(lat, lng);
        }
      }
    } catch (_) {}
    return null;
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final location = await _searchLocationWithGeocoding(query);
      if (mounted) Navigator.of(context).pop();
      if (location != null) {
        await _addLocationWithBoundary(query, location);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$query 위치 표시 완료')));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('위치를 찾을 수 없습니다.')));
        }
      }
    } catch (_) {
      if (mounted) Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('검색 중 오류 발생')));
    }
  }

  void _startAnalysis() {
    final address = _searchController.text.trim().isEmpty ? '연남동' : _searchController.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationLoadingPage(selectedAddress: address),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF),
        elevation: 0,
        title: const Text(
          "입지 선택",
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
            // 검색창
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '예: 연남동',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                      ),
                      onSubmitted: (_) => _performSearch(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF111827),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    child: const Text("검색", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),

            // 지도 카드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: NaverMap(
                    onMapReady: (controller) async {
                      _mapController = controller;
                      await _addLocationWithBoundary('연남동', const NLatLng(37.5610, 126.9258));
                    },
                    options: const NaverMapViewOptions(
                      mapType: NMapType.basic,
                      initialCameraPosition: NCameraPosition(
                        target: NLatLng(37.5665, 126.9780),
                        zoom: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '지도를 확인하고 입지를 선택한 후\n분석을 시작해주세요.',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
              ),
            ),
            const Spacer(),

            // 분석 시작 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _startAnalysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('분석 시작'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
