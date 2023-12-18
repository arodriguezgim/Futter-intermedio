import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState({
    this.isReady = false,
    this.followUser = false,
    this.markers = const [],
    this.controller,
  });

  // Generar copyWith
  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation$;
  MapNotifier() : super(MapState());

  Stream<(double, double)> trackUser() async* {
    await for (final position in Geolocator.getPositionStream()) {
      yield (position.latitude, position.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  goToLocation(double lat, double lng) {
    final newPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
    );

    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  toggleFollowUser() {
    state = state.copyWith(followUser: !state.followUser);

    if (state.followUser) {
      userLocation$ = trackUser().listen((position) {
        goToLocation(position.$1, position.$2);
      });
    } else {
      userLocation$?.cancel();
    }
  }
}

final mapControllerProvider =
    StateNotifierProvider<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
