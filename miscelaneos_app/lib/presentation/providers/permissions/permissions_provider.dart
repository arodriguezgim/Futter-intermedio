//state notifier provider

import 'package:permission_handler/permission_handler.dart';

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
