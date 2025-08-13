import 'package:test/test.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

void main() {
  group("Prueba de Palabras", () {
    test("Crear palabra", () {
      String ingles = "Hello";
      String espanol = "Hola";
      String definicion = "Saludo";
      List<String> ejemplos = ["Hello world", "Hello world 2"];
      Palabra palabra = Palabra(espanol, ingles, definicion, ejemplos);
      expect(palabra.ingles, equals(ingles));
      expect(palabra.espanol, equals(espanol));
      expect(palabra.definicion, equals(definicion));
      expect(palabra.ejemplos, equals(ejemplos));
    });

    test("Comparar dos palabras", () {
      Palabra palabra1 = Palabra("Hola", "Hello", "Saludo", ["Hola mundo"]);
      Palabra palabra2 = Palabra("Hola", "Hello", "Saludo", ["Hola mundo"]);
      Palabra palabra3 =
          Palabra("Holaaaa", "Hallo", "Saludddddooooo", ["Hoal mundo 2"]);
      expect(palabra1 == palabra2, true);
      expect(palabra1 == palabra3, false);
      expect(palabra2 == palabra3, false);
    });
  });
}
