import 'package:test/test.dart';
import 'package:study_buddy/src/functions/comparar_palabras.dart';

void main() {
  group(
    "Función de comparar frases",
    () {
      test(
        "Comparar una única palabra",
        () {
          String palabra1 = "hola";
          String palabra2 = "hola";
          String palabra3 = "adios";

          expect(compararFrases(palabra1, palabra2), true);
          expect(compararFrases(palabra1, palabra3), false);
          expect(compararFrases(palabra2, palabra3), false);
        },
      );

      test(
        "Comparar una frase sin exceso de espacios",
        () {
          String frase1 = "hola mundo como estas";
          String frase2 = "hola mundo como estas";
          String frase3 = "adios mundo hasta luego";

          expect(compararFrases(frase1, frase2), true);
          expect(compararFrases(frase1, frase3), false);
          expect(compararFrases(frase2, frase3), false);
        },
      );

      test(
        "Comparar una frase con exceso de espacios",
        () {
          String frase1 = "hola    mundo como estas";
          String frase2 = "hola mundo    como estas";
          String frase3 = "adios    mundo hasta luego";

          expect(compararFrases(frase1, frase2), true);
          expect(compararFrases(frase1, frase3), false);
          expect(compararFrases(frase2, frase3), false);
        },
      );

      test(
        "Comparar frases con mayúsculas y minúsculas",
        () {
          String frase1 = "hola mundo como estas";
          String frase2 = "Hola mundo como estas";
          String frase3 = "HOLA MUNDO COMO ESTAS";

          expect(compararFrases(frase1, frase2), true);
          expect(compararFrases(frase1, frase3), true);
          expect(compararFrases(frase2, frase3), true);
        },
      );
      test(
        "Comparar frases con signos de puntuación",
        () {
          String frase1 = "hola mundo como estas";
          String frase2 = "hola, mundo como estas";
          String frase3 = "hola mundo, como estas";
          String frase4 = "hola mundo como estas?";
          String frase5 = "hola mundo como estas!";

          expect(compararFrases(frase1, frase2), true);
          expect(compararFrases(frase1, frase3), true);
          expect(compararFrases(frase2, frase3), true);
          expect(compararFrases(frase2, frase3), true);
          expect(compararFrases(frase4, frase5), true);
          expect(compararFrases(frase4, frase3), true);
        },
      );

      test(
        "Test combinado",
        () {
          String frase1 = "hola mundo como estas";
          String frase2 = "hola, mundo como estas";
          String frase3 = "¡Hola Mundo!, ¿como estas?";

          expect(compararFrases(frase1, frase2), true);
          expect(compararFrases(frase1, frase3), true);
          expect(compararFrases(frase2, frase3), true);
        },
      );
    },
  );
}
