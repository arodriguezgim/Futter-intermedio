import 'package:random_name_generator/random_name_generator.dart';

class RandomGenerator {
  static String getRandomName() {
    final randomNames = RandomNames(Zone.spain);
    return randomNames.fullName();
  }

  //Metodo para generer nombres aleatorios.
  static Stream<String> randomNamesStream() {
    return Stream.periodic(
      const Duration(seconds: 2),
      (computationCount) {
        print('Stream new value');
        return getRandomName();
      },
    );
  }
}
