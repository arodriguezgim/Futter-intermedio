import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_app/presentation/providers/providers.dart';
//

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {
    final permissions = ref.watch(permissionsProvider);

    //final appState = ref.watch(appStateProvider);
    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          title: const Text('Cámara'),
          subtitle: Text(permissions.cameraGranted ? 'Permitido' : 'Denegado'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted,
          title: const Text('Galería de Fotos'),
          subtitle:
              Text(permissions.photoLibraryGranted ? 'Permitido' : 'Denegado'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestFotosAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          title: const Text('Localización'),
          subtitle:
              Text(permissions.locationGranted ? 'Permitido' : 'Denegado'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          title: const Text('Sensores'),
          subtitle: Text(permissions.sensorsGranted ? 'Permitido' : 'Denegado'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
        /*
        ListTile(
          title: Text('$appState'),
        ),
        */
      ],
    );
  }
}
