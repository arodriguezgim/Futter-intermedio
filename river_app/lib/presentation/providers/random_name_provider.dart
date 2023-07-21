import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/config.dart';

final randomNameProvider = StateProvider<String>((ref) {
  print('RandomName Provider');
  return RandomGenerator.getRandomName();
});
