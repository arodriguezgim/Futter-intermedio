import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos_app/config/config.dart';
import 'package:miscelaneos_app/presentation/providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

// Nos permite a nosotros observar la instancia de la aplicacion
class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //Creamos el observador
    WidgetsBinding.instance.addObserver(this);
    ref.read(permissionsProvider.notifier).checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //En este punto me voy a enterar del estado en el que está la App
    /*
    resumed -> De segundo plano a primer plano
    inactive -> Pasa a estar en segundo plano
    paused -> a background
    detached -> Finalizada
    */
    // El estado me dirá como se encuentra l a aplicacion
    print('Estado: $state');
    ref.read(appStateProvider.notifier).state = state;
    if (state == AppLifecycleState.resumed) {
      ref.read(permissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
