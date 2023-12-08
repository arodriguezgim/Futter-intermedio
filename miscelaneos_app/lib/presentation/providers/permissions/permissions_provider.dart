//state notifier provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// State Notifier Provider
final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWheInUse: permissionsArray[5],
    );
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestFotosAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWheInUse;

  //creamos el constructor iniciados a denegado
  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWheInUse = PermissionStatus.denied,
  });

  // Realizamos los getters
  get cameraGranted => camera == PermissionStatus.granted;
  get photoLibraryGranted => photoLibrary == PermissionStatus.granted;
  get sensorsGranted => sensors == PermissionStatus.granted;
  get locationGranted => location == PermissionStatus.granted;
  get locationAlwaysGranted => locationAlways == PermissionStatus.granted;
  get locationWheInUseGranted => locationWheInUse == PermissionStatus.granted;

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWheInUse,
  }) {
    return PermissionsState(
      camera: camera ?? this.camera,
      photoLibrary: photoLibrary ?? this.photoLibrary,
      sensors: sensors ?? this.sensors,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWheInUse: locationWheInUse ?? this.locationWheInUse,
    );
  }
}
