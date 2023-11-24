import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*
    resumed -> De segundo plano a primer plano
    inactive -> Pasa a estar en segundo plano
    paused -> a background
    detached -> Finalizada
*/

final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  // Cuando la App se lanza está en resumed, por eso envío esto inicialmente.
  return AppLifecycleState.resumed;
});
