import 'dart:math';

class RandomStringGeneratorService {
  String source = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random random = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => source.codeUnitAt(random.nextInt(source.length))));
}
