// ignore_for_file: avoid_print

import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/queue.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

void main() {
  group("Cola", () {
    test("La cola no deja sacar elementos cuando está vacía", () {
      Queue queue = Queue<int>(3);
      expect(() => queue.dequeue(), throwsException);
    });

    test("La cola no deja entrever elementos cuando está vacía", () {
      Queue queue = Queue<int>(3);
      expect(() => queue.peek(), throwsException);
    });
    test("La cola no deja insertar elementos cuando está llena", () {
      Queue queue = Queue<int>(3);
      queue.enqueue(1);
      queue.enqueue(2);
      queue.enqueue(3);
      expect(() => queue.enqueue(4), throwsException);
    });

    test("La cola funciona correctamente (FIFO).", () {
      Queue queue = Queue<int>(4);
      queue.enqueue(1);
      queue.enqueue(2);
      queue.enqueue(3);
      queue.enqueue(4);
      expect(queue.dequeue(), 1);
      expect(queue.dequeue(), 2);
      expect(queue.dequeue(), 3);
      expect(queue.dequeue(), 4);
    });

    test("La búsqueda funciona correctamente", () {
      Queue queue = Queue<int>(4);
      queue.enqueue(1);
      queue.enqueue(2);
      queue.enqueue(3);
      queue.enqueue(4);
      expect(queue.search(1), true);
      expect(queue.search(2), true);
      expect(queue.search(3), true);
      expect(queue.search(4), true);
      expect(queue.search(5), false);
    });

    test("Tiempo de inserción, búsqueda y elimninación de 10000 datos",
        () async => pruebaNDatosQueue(10000));

    test("Tiempo de inserción, búsqueda y elimninación de 20000 datos",
        () async => pruebaNDatosQueue(20000));

    test("Tiempo de inserción, búsqueda y elimninación de 30000 datos",
        () async => pruebaNDatosQueue(30000));

    test("Tiempo de inserción, búsqueda y elimninación de 40000 datos",
        () async => pruebaNDatosQueue(40000));

    test("Tiempo de inserción, búsqueda y elimninación de 50000 datos",
        () async => pruebaNDatosQueue(50000));

    test("Tiempo de inserción, búsqueda y elimninación de 60000 datos",
        () async => pruebaNDatosQueue(60000));

    test("Tiempo de inserción, búsqueda y elimninación de 70000 datos",
        () async => pruebaNDatosQueue(70000));

    test("Tiempo de inserción, búsqueda y elimninación de 80000 datos",
        () async => pruebaNDatosQueue(80000));

    test("Tiempo de inserción, búsqueda y elimninación de 90000 datos",
        () async => pruebaNDatosQueue(90000));

    test("Tiempo de inserción, búsqueda y elimninación de 100000 datos",
        () async => pruebaNDatosQueue(100000));
  });

  group("Tiempo de inserción, búsqueda y eliminación para String", () {
    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosQueueString(10000));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () => pruebaNDatosQueueString(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () => pruebaNDatosQueueString(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () => pruebaNDatosQueueString(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosQueueString(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () => pruebaNDatosQueueString(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () => pruebaNDatosQueueString(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () => pruebaNDatosQueueString(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () => pruebaNDatosQueueString(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosQueueString(100000));

    test("Tiempo de inserción, búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosQueueString(200000));

    test("Tiempo de inserción, búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosQueueString(300000));

    test("Tiempo de inserción, búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosQueueString(400000));

    test("Tiempo de inserción, búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosQueueString(500000));

    test("Tiempo de inserción, búsqueda y eliminación de 600000 datos",
        () => pruebaNDatosQueueString(600000));

    test("Tiempo de inserción, búsqueda y eliminación de 700000 datos",
        () => pruebaNDatosQueueString(700000));

    test("Tiempo de inserción, búsqueda y eliminación de 800000 datos",
        () => pruebaNDatosQueueString(800000));
  });
}

pruebaNDatosQueue(int N) async {
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
  Queue<Palabra> lista = Queue<Palabra>(palabras.length);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    Map<String, dynamic> json = palabras[i] as Map<String, dynamic>;
    Palabra palabra = Palabra.fromJson(json);
    lista.enqueue(palabra);
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
    Palabra palabra = lista.dequeue();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}

pruebaNDatosQueueString(int N) {
  print("Prueba con $N datos");
  Queue lista = Queue<String>(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    lista.enqueue("Palabra $i");
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
    lista.dequeue();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
