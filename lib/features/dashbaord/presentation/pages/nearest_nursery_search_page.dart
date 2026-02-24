import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';

class SearchNearestNurseryPage extends StatefulWidget {
  const SearchNearestNurseryPage({super.key});

  @override
  State<SearchNearestNurseryPage> createState() =>
      _SearchNearestNurseryPageState();
}

class _SearchNearestNurseryPageState extends State<SearchNearestNurseryPage> {
  static const _defaultUserLocation = _LatLng(27.7172, 85.3240);

  static const List<_Nursery> _nurseries = [
    _Nursery(
      name: 'Green Leaf Nursery',
      area: 'Maharajgunj, Kathmandu',
      latLng: _LatLng(27.7390, 85.3343),
    ),
    _Nursery(
      name: 'Blooming Buds',
      area: 'Kupondole, Lalitpur',
      latLng: _LatLng(27.6847, 85.3193),
    ),
    _Nursery(
      name: 'Sajha Plant House',
      area: 'Bhaktapur Durbar Square',
      latLng: _LatLng(27.6710, 85.4298),
    ),
    _Nursery(
      name: 'Bagan Point',
      area: 'Narayangarh, Chitwan',
      latLng: _LatLng(27.6838, 84.4320),
    ),
    _Nursery(
      name: 'Himal Flora Hub',
      area: 'Lakeside, Pokhara',
      latLng: _LatLng(28.2096, 83.9856),
    ),
    _Nursery(
      name: 'Evergreen Outlet',
      area: 'Gol Park, Butwal',
      latLng: _LatLng(27.7006, 83.4483),
    ),
  ];

  static const Map<String, _LatLng> _knownLocations = {
    'kathmandu': _LatLng(27.7172, 85.3240),
    'lalitpur': _LatLng(27.6588, 85.3247),
    'bhaktapur': _LatLng(27.6710, 85.4298),
    'pokhara': _LatLng(28.2096, 83.9856),
    'chitwan': _LatLng(27.6838, 84.4320),
    'butwal': _LatLng(27.7006, 83.4483),
    'biratnagar': _LatLng(26.4525, 87.2718),
  };

  final TextEditingController _locationController = TextEditingController();

  _LatLng _searchCenter = _defaultUserLocation;
  String _locationLabel = 'Current location';

  List<_NurseryDistance> get _nearestNurseries {
    final ranked =
        _nurseries
            .map(
              (nursery) => _NurseryDistance(
                nursery: nursery,
                distanceKm: _haversineKm(_searchCenter, nursery.latLng),
              ),
            )
            .toList()
          ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return ranked;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _searchByQuery() {
    final query = _locationController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return;
    }

    final coordinates = _knownLocations[query];
    if (coordinates == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location not recognized. Try Kathmandu, Lalitpur, Bhaktapur, Pokhara, Chitwan, Butwal or Biratnagar.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _searchCenter = coordinates;
      _locationLabel = _capitalize(query);
    });
  }

  void _useCurrentLocation() {
    setState(() {
      _searchCenter = _defaultUserLocation;
      _locationLabel = 'Current location';
      _locationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final nearestNurseries = _nearestNurseries;

    return Scaffold(
      appBar: AppBar(title: const Text('Search Nearest Nursery')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _searchByQuery(),
                        decoration: InputDecoration(
                          hintText: 'Enter city (e.g. Kathmandu)',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      onPressed: _searchByQuery,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: 'Use current location',
                      onPressed: _useCurrentLocation,
                      icon: const Icon(Icons.my_location),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Showing results near: $_locationLabel',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: _InteractiveNurseryMap(
                    center: _searchCenter,
                    nurseries: _nurseries,
                    topNearestNames: nearestNurseries
                        .take(3)
                        .map((item) => item.nursery.name)
                        .toSet(),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView.separated(
                    itemCount: nearestNurseries.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = nearestNurseries[index];
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: index < 3
                                ? Colors.green.shade100
                                : Colors.grey.shade200,
                            child: Icon(
                              Icons.local_florist,
                              color: index < 3
                                  ? Colors.green.shade800
                                  : Colors.black54,
                            ),
                          ),
                          title: Text(item.nursery.name),
                          subtitle: Text(item.nursery.area),
                          trailing: Text(
                            '${item.distanceKm.toStringAsFixed(1)} km',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
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

class _InteractiveNurseryMap extends StatelessWidget {
  const _InteractiveNurseryMap({
    required this.center,
    required this.nurseries,
    required this.topNearestNames,
  });

  final _LatLng center;
  final List<_Nursery> nurseries;
  final Set<String> topNearestNames;

  static const double _mapWidth = 1000;
  static const double _mapHeight = 650;
  static const double _minLat = 26.3;
  static const double _maxLat = 30.5;
  static const double _minLng = 80.0;
  static const double _maxLng = 88.5;

  Offset _toOffset(_LatLng point) {
    final x = ((point.lng - _minLng) / (_maxLng - _minLng)) * _mapWidth;
    final y = ((point.lat - _minLat) / (_maxLat - _minLat)) * _mapHeight;
    return Offset(x, _mapHeight - y);
  }

  @override
  Widget build(BuildContext context) {
    final centerPoint = _toOffset(center);
    final markers = nurseries
        .map(
          (nursery) => (
            nursery,
            _toOffset(nursery.latLng),
            topNearestNames.contains(nursery.name),
          ),
        )
        .toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: InteractiveViewer(
        maxScale: 5,
        minScale: 1,
        child: Container(
          width: _mapWidth,
          height: _mapHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE9F8E4), Color(0xFFD8F0D0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              CustomPaint(
                size: const Size(_mapWidth, _mapHeight),
                painter: _MapGridPainter(),
              ),
              Positioned(
                left: centerPoint.dx - 9,
                top: centerPoint.dy - 9,
                child: const Icon(
                  Icons.my_location,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
              ...markers.map(
                (marker) => Positioned(
                  left: marker.$2.dx - 10,
                  top: marker.$2.dy - 24,
                  child: Tooltip(
                    message: marker.$1.name,
                    child: Icon(
                      Icons.location_on,
                      size: 24,
                      color: marker.$3 ? Colors.red : Colors.green.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += 80) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Nursery {
  const _Nursery({
    required this.name,
    required this.area,
    required this.latLng,
  });

  final String name;
  final String area;
  final _LatLng latLng;
}

class _NurseryDistance {
  const _NurseryDistance({required this.nursery, required this.distanceKm});

  final _Nursery nursery;
  final double distanceKm;
}

class _LatLng {
  const _LatLng(this.lat, this.lng);

  final double lat;
  final double lng;
}

double _haversineKm(_LatLng a, _LatLng b) {
  const earthRadiusKm = 6371.0;
  final latDistance = _toRadians(b.lat - a.lat);
  final lngDistance = _toRadians(b.lng - a.lng);
  final aa =
      sin(latDistance / 2) * sin(latDistance / 2) +
      cos(_toRadians(a.lat)) *
          cos(_toRadians(b.lat)) *
          sin(lngDistance / 2) *
          sin(lngDistance / 2);
  final c = 2 * atan2(sqrt(aa), sqrt(1 - aa));
  return earthRadiusKm * c;
}

double _toRadians(double degree) {
  return degree * (pi / 180);
}

String _capitalize(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}
