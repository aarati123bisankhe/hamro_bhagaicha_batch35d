import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_client.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';

class SearchNearestNurseryPage extends ConsumerStatefulWidget {
  const SearchNearestNurseryPage({super.key});

  @override
  ConsumerState<SearchNearestNurseryPage> createState() =>
      _SearchNearestNurseryPageState();
}

class _SearchNearestNurseryPageState
    extends ConsumerState<SearchNearestNurseryPage> {
  static const LatLng _defaultCenter = LatLng(27.7172, 85.3240);

  static const List<_NurserySeed> _seedNurseries = [
    _NurserySeed(
      name: 'Green Leaf Nursery',
      area: 'Maharajgunj, Kathmandu',
      lat: 27.7390,
      lng: 85.3343,
    ),
    _NurserySeed(
      name: 'Blooming Buds',
      area: 'Kupondole, Lalitpur',
      lat: 27.6847,
      lng: 85.3193,
    ),
    _NurserySeed(
      name: 'Sajha Plant House',
      area: 'Bhaktapur Durbar Square',
      lat: 27.6710,
      lng: 85.4298,
    ),
    _NurserySeed(
      name: 'Bagan Point',
      area: 'Narayangarh, Chitwan',
      lat: 27.6838,
      lng: 84.4320,
    ),
    _NurserySeed(
      name: 'Himal Flora Hub',
      area: 'Lakeside, Pokhara',
      lat: 28.2096,
      lng: 83.9856,
    ),
    _NurserySeed(
      name: 'Evergreen Outlet',
      area: 'Gol Park, Butwal',
      lat: 27.7006,
      lng: 83.4483,
    ),
  ];

  static const Map<String, LatLng> _knownLocations = {
    'kathmandu': LatLng(27.7172, 85.3240),
    'lalitpur': LatLng(27.6588, 85.3247),
    'bhaktapur': LatLng(27.6710, 85.4298),
    'pokhara': LatLng(28.2096, 83.9856),
    'chitwan': LatLng(27.6838, 84.4320),
    'butwal': LatLng(27.7006, 83.4483),
    'biratnagar': LatLng(26.4525, 87.2718),
  };

  final TextEditingController _locationController = TextEditingController();

  GoogleMapController? _mapController;
  LatLng _searchCenter = _defaultCenter;
  String _locationLabel = 'Current location';
  bool _isLoading = false;
  String? _errorMessage;
  List<_NurseryResult> _nearestNurseries = const [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    await _useCurrentLocation();
  }

  Future<void> _searchByQuery() async {
    final query = _locationController.text.trim();
    final lowerQuery = query.toLowerCase();

    final targetCenter = _knownLocations[lowerQuery] ?? _searchCenter;

    setState(() {
      if (query.isNotEmpty) {
        _searchCenter = targetCenter;
        _locationLabel = query;
      }
    });

    await _loadNearestNurseries(
      center: targetCenter,
      query: query.isEmpty ? null : query,
    );
    await _moveMapTo(targetCenter);
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _determinePosition();
      final center = LatLng(position.latitude, position.longitude);

      if (!mounted) return;
      setState(() {
        _searchCenter = center;
        _locationLabel = 'Current location';
        _locationController.clear();
      });

      await _loadNearestNurseries(center: center);
      await _moveMapTo(center);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage =
            'Location unavailable. Showing nearest fallback nurseries.';
      });
      await _loadNearestNurseries(center: _searchCenter);
    }
  }

  Future<void> _loadNearestNurseries({
    required LatLng center,
    String? query,
  }) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ref
          .read(apiClientProvider)
          .get(
            ApiEndpoints.nearestNurseries,
            queryParameters: {
              'lat': center.latitude,
              'lng': center.longitude,
              if (query != null && query.isNotEmpty) 'q': query,
              'limit': 20,
            },
          );

      final parsed = _parseNurseryResponse(response.data, center, query);

      if (!mounted) return;
      setState(() {
        _nearestNurseries = parsed.isNotEmpty
            ? parsed
            : _fallbackNearest(center, query);
        _isLoading = false;
      });
    } on DioException {
      if (!mounted) return;
      setState(() {
        _nearestNurseries = _fallbackNearest(center, query);
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _nearestNurseries = _fallbackNearest(center, query);
        _isLoading = false;
      });
    }
  }

  List<_NurseryResult> _parseNurseryResponse(
    dynamic payload,
    LatLng center,
    String? query,
  ) {
    final listData = payload is Map<String, dynamic>
        ? payload['data'] ?? payload['results'] ?? payload['nurseries']
        : payload;

    if (listData is! List) {
      return const [];
    }

    final items = listData
        .whereType<Map<String, dynamic>>()
        .map((item) {
          final location = item['location'] is Map<String, dynamic>
              ? item['location'] as Map<String, dynamic>
              : null;

          final lat =
              _asDouble(item['latitude']) ??
              _asDouble(item['lat']) ??
              _asDouble(location?['latitude']) ??
              _asDouble(location?['lat']);

          final lng =
              _asDouble(item['longitude']) ??
              _asDouble(item['lng']) ??
              _asDouble(item['lon']) ??
              _asDouble(location?['longitude']) ??
              _asDouble(location?['lng']);

          if (lat == null || lng == null) {
            return null;
          }

          final fallbackDistance =
              Geolocator.distanceBetween(
                center.latitude,
                center.longitude,
                lat,
                lng,
              ) /
              1000;

          final apiDistanceKm =
              _asDouble(item['distanceKm']) ?? _asDouble(item['distance']);

          return _NurseryResult(
            name: (item['name'] ?? 'Nursery').toString(),
            area:
                (item['area'] ??
                        item['address'] ??
                        item['locationName'] ??
                        'Unknown area')
                    .toString(),
            lat: lat,
            lng: lng,
            distanceKm: apiDistanceKm ?? fallbackDistance,
          );
        })
        .whereType<_NurseryResult>()
        .toList();

    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      final filtered = items.where((item) {
        final haystack = '${item.name} ${item.area}'.toLowerCase();
        return haystack.contains(q);
      }).toList();
      filtered.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      return filtered;
    }

    items.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return items;
  }

  List<_NurseryResult> _fallbackNearest(LatLng center, String? query) {
    final q = query?.trim().toLowerCase();

    final candidates = _seedNurseries.where((seed) {
      if (q == null || q.isEmpty) {
        return true;
      }
      return '${seed.name} ${seed.area}'.toLowerCase().contains(q);
    });

    final ranked = candidates.map((seed) {
      final distanceKm =
          Geolocator.distanceBetween(
            center.latitude,
            center.longitude,
            seed.lat,
            seed.lng,
          ) /
          1000;

      return _NurseryResult(
        name: seed.name,
        area: seed.area,
        lat: seed.lat,
        lng: seed.lng,
        distanceKm: distanceKm,
      );
    }).toList();

    ranked.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return ranked;
  }

  Future<void> _moveMapTo(LatLng target) async {
    await _mapController?.animateCamera(CameraUpdate.newLatLng(target));
  }

  Set<Marker> _buildMarkers() {
    final topThreeNames = _nearestNurseries.take(3).map((e) => e.name).toSet();

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('search_center'),
        position: _searchCenter,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: _locationLabel),
      ),
    };

    for (final item in _nearestNurseries) {
      final isTop = topThreeNames.contains(item.name);
      markers.add(
        Marker(
          markerId: MarkerId('${item.name}_${item.lat}_${item.lng}'),
          position: LatLng(item.lat, item.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            isTop ? BitmapDescriptor.hueRed : BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: item.name,
            snippet: '${item.area} • ${item.distanceKm.toStringAsFixed(1)} km',
          ),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
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
                          hintText: 'Search city or area',
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
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _searchByQuery,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    const SizedBox(width: 6),
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
                if (_errorMessage != null) ...[
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _searchCenter,
                        zoom: 11,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      markers: _buildMarkers(),
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: LinearProgressIndicator(),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _nearestNurseries.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = _nearestNurseries[index];
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
                          title: Text(item.name),
                          subtitle: Text(item.area),
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

  Future<Position> _determinePosition() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied.');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}

class _NurserySeed {
  const _NurserySeed({
    required this.name,
    required this.area,
    required this.lat,
    required this.lng,
  });

  final String name;
  final String area;
  final double lat;
  final double lng;
}

class _NurseryResult {
  const _NurseryResult({
    required this.name,
    required this.area,
    required this.lat,
    required this.lng,
    required this.distanceKm,
  });

  final String name;
  final String area;
  final double lat;
  final double lng;
  final double distanceKm;
}

double? _asDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value);
  }
  return null;
}
