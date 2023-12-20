import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos_app/presentation/providers/location/map_controller_provider.dart';
import 'package:miscelaneos_app/presentation/providers/location/user_location_provider.dart';
import 'package:miscelaneos_app/presentation/providers/location/watch_location_provider.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    //final watchUserLocation = ref.watch(watchLocationProvider);
    final userInitialLocation = ref.watch(userLocationProvider);
    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControls(latitude: data.$1, longitude: data.$2),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(children: [
      _MapView(
        initialLat: latitude,
        initialLng: longitude,
      ),
      //Boton para salir de la pantalla
      Positioned(
        top: 40,
        left: 20,
        child: IconButton.filledTonal(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      // Ir a la posicion del usuario
      Positioned(
        bottom: 40,
        left: 20,
        child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .goToLocation(latitude, longitude);
            },
            icon: Icon(Icons.location_searching)),
      ),
      // Seguir Usuario
      Positioned(
        bottom: 90,
        left: 20,
        child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).toggleFollowUser();
            },
            icon: Icon(mapControllerState.followUser
                ? Icons.directions_run
                : Icons.accessibility_new_outlined)),
      ),
      // ! Crear marcador
      Positioned(
        bottom: 140,
        left: 20,
        child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .addMarkerCurrentPosition();
            },
            icon: Icon(Icons.pin_drop)),
      ),
    ]);
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;
  const _MapView(
      {super.key, required this.initialLat, required this.initialLng});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);
    return SafeArea(
      child: GoogleMap(
        markers: mapController.markersSet,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLat, widget.initialLng), zoom: 15),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          ref.read(mapControllerProvider.notifier).setMapController(controller);
        },
        onLongPress: (latlng) {
          ref.read(mapControllerProvider.notifier).addMarker(
              latlng.latitude, latlng.longitude,
              name: 'Custom Marker');
        },
      ),
    );
  }
}
