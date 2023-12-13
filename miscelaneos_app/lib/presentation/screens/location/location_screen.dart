import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_app/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocationAsync = ref.watch(userLocationProvider);

    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LocationScreen'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Ubicación Actual:',
              style: Theme.of(context).textTheme.headlineMedium),
          userLocationAsync.when(
            data: (value) => Text(
              '$value',
            ),
            error: (error, StackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
          const SizedBox(height: 30),
          Text('Seguimiento de ubicación:',
              style: Theme.of(context).textTheme.headlineMedium),
          watchLocationAsync.when(
            data: (value) => Text(
              '$value',
            ),
            error: (error, StackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          )
        ]),
      ),
    );
  }
}
