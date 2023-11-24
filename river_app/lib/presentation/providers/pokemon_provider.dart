import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/config.dart';

final pokemonIdProvider = StateProvider<int>((ref) {
  return 1;
});

final pokemonNAmeProvider = FutureProvider<String>((ref) async {
  final id = ref.watch(pokemonIdProvider);
  //Mandamos llamar la peticion
  final name = await PokemonService.getPokemonName(id);
  return name;
});

//final pokemonNAmeProvider = FutureProvider.family<String, int>((ref, id) async {
  //Mandamos llamar la peticion
  //final name = await PokemonService.getPokemonName(id);
  //return name;
//});
