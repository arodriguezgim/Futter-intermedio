import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/config.dart';

final namesStreamProvider = StreamProvider.autoDispose<String>((ref) async* {
  await for (final name in RandomGenerator.randomNamesStream()) {
    yield name;
  }
});

/*
//async* regresa un stream
final namesStreamProvider = StreamProvider<List<String>>((ref) async* {
  //yield está pensado para los Streams. 1ª emision, 2ª emision...
  await Future.delayed(const Duration(seconds: 2));
  yield [];
  await Future.delayed(const Duration(seconds: 2));

  yield ['Fernando'];
  await Future.delayed(const Duration(seconds: 2));

  yield ['Fernando', 'Alberto'];
  await Future.delayed(const Duration(seconds: 2));

  yield ['Fernando', 'Alberto', 'Juan'];
});
*/