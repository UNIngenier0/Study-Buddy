import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/set.dart';
import 'package:study_buddy/src/services/firestore_service.dart';

void main() {
  group("Funcionamiento del set", () {
    test("Inserción y Búsqueda", () {
      Palabra palabra1 = Palabra(
          "Hola", "Hello", "Saludo casual", ["Hello!", "Hi!", "Hey!"], "");
      Palabra palabra2 = Palabra("Adiós", "Goodbye", "Despedida casual",
          ["Goodbye!", "Bye!", "See you!"], "");
      Palabra palabra3 = Palabra("Gracias", "Thanks", "Agradecimiento",
          ["Thanks!", "Thank you!", "Thank you very much!"], "");

      MiSet<Palabra> set = MiSet(10);
      set.insert(palabra1);
      set.insert(palabra2);

      expect(set.contains(palabra1), true);
      expect(set.contains(palabra2), true);
      expect(set.contains(palabra3), false);
    });
    test("Eliminación", () {
      Palabra palabra1 = Palabra(
          "Hola", "Hello", "Saludo casual", ["Hello!", "Hi!", "Hey!"], "");
      Palabra palabra2 = Palabra("Adiós", "Goodbye", "Despedida casual",
          ["Goodbye!", "Bye!", "See you!"], "");
      Palabra palabra3 = Palabra("Gracias", "Thanks", "Agradecimiento",
          ["Thanks!", "Thank you!", "Thank you very much!"], "");

      MiSet<Palabra> set = MiSet(10);
      set.insert(palabra1);
      set.insert(palabra2);
      set.insert(palabra3);

      set.remove(palabra2);

      expect(set.contains(palabra1), true);
      expect(set.contains(palabra2), false);
      expect(set.contains(palabra3), true);
    });

    test("Unicidad", () {
      Palabra palabra1 = Palabra(
          "Hola", "Hello", "Saludo casual", ["Hello!", "Hi!", "Hey!"], "");
      Palabra palabra2 = Palabra("Adiós", "Goodbye", "Despedida casual",
          ["Goodbye!", "Bye!", "See you!"], "");
      Palabra palabra3 = Palabra("Gracias", "Thanks", "Agradecimiento",
          ["Thanks!", "Thank you!", "Thank you very much!"], "");

      MiSet<Palabra> set = MiSet(10);
      set.insert(palabra1);
      set.insert(palabra2);
      set.insert(palabra3);
      set.insert(palabra1);

      expect(set.size, 3);
    });

    test("Elementos ausentes", () {
      Palabra palabra1 = Palabra(
          "Hola", "Hello", "Saludo casual", ["Hello!", "Hi!", "Hey!"], "");
      Palabra palabra2 = Palabra("Adiós", "Goodbye", "Despedida casual",
          ["Goodbye!", "Bye!", "See you!"], "");
      Palabra palabra3 = Palabra("Gracias", "Thanks", "Agradecimiento",
          ["Thanks!", "Thank you!", "Thank you very much!"], "");

      MiSet<Palabra> set = MiSet(10);
      set.insert(palabra1);
      set.insert(palabra2);

      expect(set.contains(palabra1), true);
      expect(set.contains(palabra2), true);
      expect(set.contains(palabra3), false);

      expect(() => set.remove(palabra3), throwsException);
    });
    test("Conjunto vacío", () {
      MiSet<int> set = MiSet(10);
      expect(set.empty, true);
    });
  });

  group("Tiempo de inserción, búsqueda y eliminación para String", () {
    test("Tiempo de inserción, búsqueda y eliminación de 500 datos",
        () => pruebaNDatosSet(500));

    test("Tiempo de inserción, búsqueda y eliminación de 1000 datos",
        () => pruebaNDatosSet(1000));

    test("Tiempo de inserción, búsqueda y eliminación de 1500 datos",
        () => pruebaNDatosSet(1500));

    test("Tiempo de inserción, búsqueda y eliminación de 2000 datos",
        () => pruebaNDatosSet(2000));

    test("Tiempo de inserción, búsqueda y eliminación de 2500 datos",
        () => pruebaNDatosSet(2500));

    test("Tiempo de inserción, búsqueda y eliminación de 3000 datos",
        () => pruebaNDatosSet(3000));

    test("Tiempo de inserción, búsqueda y eliminación de 3500 datos",
        () => pruebaNDatosSet(3500));

    test("Tiempo de inserción, búsqueda y eliminación de 4000 datos",
        () => pruebaNDatosSet(4000));

    test("Tiempo de inserción, búsqueda y eliminación de 4500 datos",
        () => pruebaNDatosSet(4500));

    test("Tiempo de inserción, búsqueda y eliminación de 5000 datos",
        () => pruebaNDatosSet(5000));

    test("Tiempo de inserción, búsqueda y eliminación de 5500 datos",
        () => pruebaNDatosSet(5500));
  });
}

pruebaNDatosSet(int N) {
  print("Prueba con $N datos");
  MiSet<String> set = MiSet(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    set.insert("palabra$i");
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(set.contains("palabra${N ~/ 2}"), true);
  expect(set.contains("palabra${N + 1}"), false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    set.remove("palabra$i");
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
