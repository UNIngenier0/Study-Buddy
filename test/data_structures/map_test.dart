import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/map.dart';

void main() {
  group("Funcionamiento del mapa", () {
    test("Inserción y Búsqueda", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.get("Hola"), 1);
      expect(map.get("Adiós"), 2);
      expect(map.get("Gracias"), 3);
    });

    test("Unicidad", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);
      map.set("Hola", 4);

      expect(map.size, 3);
    });

    test("Elementos ausentes", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.get("Hello"), null);
      expect(map.get("Bye"), null);
      expect(map.get("Thanks"), null);
    });

    test("Sobreescritura de valor", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.get("Hola"), 1);

      map.set("Hola", 4);

      expect(map.get("Hola"), 4);
    });

    test("Existencia de llaves", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.hasKey("Hola"), true);
      expect(map.hasKey("Adiós"), true);
      expect(map.hasKey("Gracias"), true);
      expect(map.hasKey("De hecho"), false);
    });

    test("Rehash", () {
      MiMap<String, int> map = MiMap(3);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.size, 3);

      map.set("De hecho", 4);

      expect(map.size, 4);
    });

    test("Eliminación de una llave", () {
      MiMap<String, int> map = MiMap(10);
      map.set("Hola", 1);
      map.set("Adiós", 2);
      map.set("Gracias", 3);

      expect(map.size, 3);

      map.remove("Hola");

      expect(map.size, 2);
      expect(map.hasKey("Hola"), false);
    });
  });

  group("Tiempo de inserción, búsqueda y eliminación", () {
    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosMap(500));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () => pruebaNDatosMap(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () => pruebaNDatosMap(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () => pruebaNDatosMap(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosMap(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () => pruebaNDatosMap(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () => pruebaNDatosMap(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () => pruebaNDatosMap(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () => pruebaNDatosMap(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosMap(100000));

    test("Tiempo de inserción, búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosMap(200000));

    test("Tiempo de inserción, búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosMap(300000));

    test("Tiempo de inserción, búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosMap(400000));

    test("Tiempo de inserción, búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosMap(500000));

    test("Tiempo de inserción, búsqueda y eliminación de 600000 datos",
        () => pruebaNDatosMap(600000));

    test("Tiempo de inserción, búsqueda y eliminación de 700000 datos",
        () => pruebaNDatosMap(700000));

    test("Tiempo de inserción, búsqueda y eliminación de 800000 datos",
        () => pruebaNDatosMap(800000));
  });
}

pruebaNDatosMap(int N) {
  print("Prueba con $N datos");
  MiMap<String, int> mapa = MiMap(10);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    mapa.set("Palabra $i", i);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();

  stopwatch.start();
  mapa.get("Palabra ${N ~/ 2}");
  mapa.get("Palabra ${N + 1}");
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();

  stopwatch.start();
  for (int i = 0; i < N; i++) {
    mapa.remove("Palabra $i");
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
