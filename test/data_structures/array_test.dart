// ignore_for_file: avoid_print

import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/array.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

void main() {
  group("Prueba de funcionamiento de un arreglo", () {
    test("El arreglo debe poder añadir elementos al final", () {
      Array<int> array = Array<int>(4);
      array.insert(1);
      array.insert(2);
      array.insert(3);
      array.insert(4);

      expect(array.pop(), 4);
      expect(array.pop(), 3);
      expect(array.pop(), 2);
      expect(array.pop(), 1);
    });

    test("El arreglo debe poder buscar elementos", () {
      Array<int> array = Array<int>(4);
      array.insert(1);
      array.insert(2);
      array.insert(3);
      array.insert(4);

      expect(array.search(1), true);
      expect(array.search(2), true);
      expect(array.search(3), true);
      expect(array.search(4), true);
      expect(array.search(5), false);
    });

    test("El arreglo debe poder eliminar elementos", () {
      Array<int> array = Array<int>(4);
      array.insert(1);
      array.insert(2);
      array.insert(3);
      array.insert(4);

      array.remove(1);
      array.remove(2);
      array.remove(3);
      array.remove(4);

      expect(array.length, 0);
      expect(array.search(1), false);
      expect(array.search(2), false);
      expect(array.search(3), false);
      expect(array.search(4), false);
    });

    test("Se debe poder cambiar un elemento en un índice específico", () {
      Array<int> array = Array<int>(4);
      array.insert(1);
      array.insert(2);
      array.insert(3);
      array.insert(4);

      array[0] = 5;
      array[1] = 6;
      array[2] = 7;
      array[3] = 8;

      expect(array[0], 5);
      expect(array[1], 6);
      expect(array[2], 7);
      expect(array[3], 8);
    });

    test("Tiempo de inserción, búsqueda y elimninación de 10000 datos",
        () async => pruebaNDatosArray(10000));

    test("Tiempo de inserción, búsqueda y elimninación de 20000 datos",
        () async => pruebaNDatosArray(20000));

    test("Tiempo de inserción, búsqueda y elimninación de 30000 datos",
        () async => pruebaNDatosArray(30000));

    test("Tiempo de inserción, búsqueda y elimninación de 40000 datos",
        () async => pruebaNDatosArray(40000));

    test("Tiempo de inserción, búsqueda y elimninación de 50000 datos",
        () async => pruebaNDatosArray(50000));

    test("Tiempo de inserción, búsqueda y elimninación de 60000 datos",
        () async => pruebaNDatosArray(60000));

    test("Tiempo de inserción, búsqueda y elimninación de 70000 datos",
        () async => pruebaNDatosArray(70000));

    test("Tiempo de inserción, búsqueda y elimninación de 80000 datos",
        () async => pruebaNDatosArray(80000));

    test("Tiempo de inserción, búsqueda y elimninación de 90000 datos",
        () async => pruebaNDatosArray(90000));

    test("Tiempo de inserción, búsqueda y elimninación de 100000 datos",
        () async => pruebaNDatosArray(100000));
  });

  group("Tiempo de inserción, búsqueda y eliminación para String", () {
    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosArrayString(10000));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () => pruebaNDatosArrayString(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () => pruebaNDatosArrayString(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () => pruebaNDatosArrayString(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosArrayString(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () => pruebaNDatosArrayString(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () => pruebaNDatosArrayString(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () => pruebaNDatosArrayString(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () => pruebaNDatosArrayString(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosArrayString(100000));

    test("Tiempo de inserción, búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosArrayString(200000));

    test("Tiempo de inserción, búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosArrayString(300000));

    test("Tiempo de inserción, búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosArrayString(400000));

    test("Tiempo de inserción, búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosArrayString(500000));

    test("Tiempo de inserción, búsqueda y eliminación de 600000 datos",
        () => pruebaNDatosArrayString(600000));

    test("Tiempo de inserción, búsqueda y eliminación de 700000 datos",
        () => pruebaNDatosArrayString(700000));

    test("Tiempo de inserción, búsqueda y eliminación de 800000 datos",
        () => pruebaNDatosArrayString(800000));
  });
}

pruebaNDatosArray(int N) async {
  String ruta;
  switch (N) {
    case 10000:
      print("Prueba con 10000 datos");
      ruta = 'assets/json/10000_datos.json';
      break;
    case 20000:
      print("Prueba con 20000 datos");
      ruta = 'assets/json/20000_datos.json';
      break;
    case 30000:
      print("Prueba con 30000 datos");
      ruta = 'assets/json/30000_datos.json';
      break;
    case 40000:
      print("Prueba con 40000 datos");
      ruta = 'assets/json/40000_datos.json';
      break;
    case 50000:
      print("Prueba con 50000 datos");
      ruta = 'assets/json/50000_datos.json';
      break;
    case 60000:
      print("Prueba con 60000 datos");
      ruta = 'assets/json/60000_datos.json';
      break;
    case 70000:
      print("Prueba con 70000 datos");
      ruta = 'assets/json/70000_datos.json';
      break;
    case 80000:
      print("Prueba con 80000 datos");
      ruta = 'assets/json/80000_datos.json';
      break;
    case 90000:
      print("Prueba con 90000 datos");
      ruta = 'assets/json/90000_datos.json';
      break;
    case 100000:
      print("Prueba con 100000 datos");
      ruta = 'assets/json/100000_datos.json';
    default:
      throw Exception("No se ha encontrado la ruta");
  }

  List palabras = await getDataFromJson(ruta);
  Array<Palabra> arreglo = Array<Palabra>(palabras.length);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    Map<String, dynamic> json = palabras[i] as Map<String, dynamic>;
    Palabra palabra = Palabra.fromJson(json);
    arreglo.insert(palabra);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(
      arreglo.search(Palabra(
          "casa", "house", "edificio para vivir", ["I live in a house"])),
      true);
  expect(
      arreglo
          .search(Palabra("Dortmund", "Tottenham", "definición", ["Ejemplo"])),
      false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    // ignore: unused_local_variable
    Palabra palabra = arreglo.pop();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}

pruebaNDatosArrayString(int N) {
  print("Prueba con $N datos");
  Array lista = Array<String>(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    lista.insert("Palabra $i");
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(lista.search("Palabra ${N ~/ 2}"), true);
  expect(lista.search("Palabra ${N + 1}"), false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    lista.pop();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
