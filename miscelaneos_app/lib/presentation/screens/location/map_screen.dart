import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos_app/presentation/providers/location/user_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPositionAsync = ref.watch(userLocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapScreen'),
      ),
      body: currentPositionAsync.when(
        data: (value) => _MapView(initialLat: value.$1, initialLng: value.$2),
        error: (error, StackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLat;
  final double initialLng;
  const _MapView(
      {super.key, required this.initialLat, required this.initialLng});

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLat, widget.initialLng), zoom: 15),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          //_controller.complete(controller);
        },
      ),
    );
  }
}
