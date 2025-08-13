// ignore_for_file: avoid_print

import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/stack.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

void main() {
  group("Pila", () {
    test("La pila no deja desapilar elementos si está vacía", () {
      Stack stack = Stack<int>(10);
      expect(() => stack.pop(), throwsException);
    });

    test("La pila no deja entrever elementos si está vacía", () {
      Stack stack = Stack<int>(10);
      expect(() => stack.peek(), throwsException);
    });

    test("La pila apila, entreve y desapila en el orden esperado (LIFO).", () {
      Stack stack = Stack<int>(10);
      stack.push(1);
      stack.push(2);
      stack.push(3);
      stack.push(4);
      stack.push(5);
      expect(stack.peek(), 5);
      expect(stack.peek(), 5);
      expect(stack.pop(), 5);
      expect(stack.pop(), 4);
      expect(stack.pop(), 3);
      expect(stack.pop(), 2);
      expect(stack.pop(), 1);
    });

    test("La pila no debe dejar insertar elementos cuando está llena.", () {
      Stack stack = Stack<int>(3);
      stack.push(1);
      stack.push(2);
      stack.push(3);
      expect(() => stack.push(4), throwsException);
    });

    test("La búsqueda funciona correctamente", () {
      Stack stack = Stack<int>(4);
      stack.push(1);
      stack.push(2);
      stack.push(3);
      stack.push(4);
      expect(stack.search(1), true);
      expect(stack.search(2), true);
      expect(stack.search(3), true);
      expect(stack.search(4), true);
      expect(stack.search(5), false);
    });

    test("Tiempo de inserción, búsqueda y elimninación de 10000 datos",
        () async => pruebaNDatosStack(10000));

    test("Tiempo de inserción, búsqueda y elimninación de 20000 datos",
        () async => pruebaNDatosStack(20000));

    test("Tiempo de inserción, búsqueda y elimninación de 30000 datos",
        () async => pruebaNDatosStack(30000));

    test("Tiempo de inserción, búsqueda y elimninación de 40000 datos",
        () async => pruebaNDatosStack(40000));

    test("Tiempo de inserción, búsqueda y elimninación de 50000 datos",
        () async => pruebaNDatosStack(50000));

    test("Tiempo de inserción, búsqueda y elimninación de 60000 datos",
        () async => pruebaNDatosStack(60000));

    test("Tiempo de inserción, búsqueda y elimninación de 70000 datos",
        () async => pruebaNDatosStack(70000));

    test("Tiempo de inserción, búsqueda y elimninación de 80000 datos",
        () async => pruebaNDatosStack(80000));

    test("Tiempo de inserción, búsqueda y elimninación de 90000 datos",
        () async => pruebaNDatosStack(90000));

    test("Tiempo de inserción, búsqueda y elimninación de 100000 datos",
        () async => pruebaNDatosStack(100000));
  });

  group("Tiempo de inserción, búsqueda y eliminación para String", () {
    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosStackString(10000));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () => pruebaNDatosStackString(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () => pruebaNDatosStackString(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () => pruebaNDatosStackString(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosStackString(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () => pruebaNDatosStackString(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () => pruebaNDatosStackString(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () => pruebaNDatosStackString(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () => pruebaNDatosStackString(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosStackString(100000));

    test("Tiempo de inserción, búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosStackString(200000));

    test("Tiempo de inserción, búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosStackString(300000));

    test("Tiempo de inserción, búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosStackString(400000));

    test("Tiempo de inserción, búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosStackString(500000));

    test("Tiempo de inserción, búsqueda y eliminación de 600000 datos",
        () => pruebaNDatosStackString(600000));

    test("Tiempo de inserción, búsqueda y eliminación de 700000 datos",
        () => pruebaNDatosStackString(700000));

    test("Tiempo de inserción, búsqueda y eliminación de 800000 datos",
        () => pruebaNDatosStackString(800000));
  });
}

pruebaNDatosStack(int N) async {
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
  Stack<Palabra> lista = Stack<Palabra>(palabras.length);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    Map<String, dynamic> json = palabras[i] as Map<String, dynamic>;
    Palabra palabra = Palabra.fromJson(json);
    lista.push(palabra);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(
      lista.search(Palabra(
          "casa", "house", "edificio para vivir", ["I live in a house"])),
      true);
  expect(
      lista.search(Palabra("Dortmund", "Tottenham", "definición", ["Ejemplo"])),
      false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    // ignore: unused_local_variable
    Palabra palabra = lista.pop();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}

pruebaNDatosStackString(int N) {
  print("Prueba con $N datos");
  Stack lista = Stack<String>(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    lista.push("Palabra $i");
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
