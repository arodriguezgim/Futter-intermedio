import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GyroscopeXYZ {
  final double x;
  final double y;
  final double z;
  GyroscopeXYZ(this.x, this.y, this.z);

  @override
  String toString() {
    return '''
    x: $x,
    y: $y,
    z: $z,
    ''';
  }
}

final gyroscopeProvider = StreamProvider<GyroscopeXYZ>((ref) async* {
  await for (final event in gyroscopeEvents) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));

    yield GyroscopeXYZ(x, y, z);
  }
});
