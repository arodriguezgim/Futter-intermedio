import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final userLocationProvider =
    FutureProvider<(double lat, double long)>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Comprobamos si tenemos permisos de ubicacion
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'Location services are disabled.';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location permissions are denied';
    }
  }
  // Y permisos denegados permanentemente
  if (permission == LocationPermission.deniedForever) {
    throw 'Location permissions are permanently denied, we cannot request permissions.';
  }

  final location = await Geolocator.getCurrentPosition();

  return (location.latitude, location.longitude);
});
