import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/presentation/providers/providers.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    // read obtiene el valor pero no es reactivo
    // watch si que es reactivo. Lo que me regresa el watch es el String que nosotros pusimos.
    final name = ref.watch(randomNameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Text(
          name,
          style: titleStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '3',
        child: const Icon(Icons.refresh_rounded),
        onPressed: () {
          //No tiene sentido usar watch porque estoy dentro de una función.
          // Se aconseja usar el read porque solo quiero leer ese provider.
          //notifier es una clase creada nosotros automaticamente para notificar a los widgets cuando hay cambio
          //update lo que nos ofrece es el valor actual que tiene en ese momento

          //ref.read(randomNameProvider.notifier ).state = 'Otro Nombre';
          //ref
          //    .read(randomNameProvider.notifier)
          //    .update((state) => state.toLowerCase());

          //Hay un método para decir a Riverpod: Solo necesito ejecutar esta funcion!: invalidate
          ref.invalidate(randomNameProvider);
        },
      ),
    );
  }
}
