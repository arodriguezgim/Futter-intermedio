import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_app/presentation/providers/sensors/gyroscope_provider.dart';

class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body: Center(
          child: gyroscope$.when(
              data: (value) => Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
              error: (error, StackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
