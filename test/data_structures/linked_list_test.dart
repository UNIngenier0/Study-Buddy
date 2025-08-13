// ignore_for_file: avoid_print

import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/linked_list.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

void main() {
  group("Lista enlazada", () {
    test("La lista debe poder añadir elementos al principio", () {
      LinkedList linkedList = LinkedList<int>();
      linkedList.pushFront(1);
      linkedList.pushFront(2);
      linkedList.pushFront(3);
      linkedList.pushFront(4);

      expect(linkedList.popFront(), 4);
      expect(linkedList.popFront(), 3);
      expect(linkedList.popFront(), 2);
      expect(linkedList.popFront(), 1);
    });

    test("La lista debe poder añadir elementos al final", () {
      LinkedList linkedList = LinkedList<int>();
      linkedList.pushBack(1);
      linkedList.pushBack(2);
      linkedList.pushBack(3);
      linkedList.pushBack(4);

      expect(linkedList.popBack(), 4);
      expect(linkedList.popBack(), 3);
      expect(linkedList.popBack(), 2);
      expect(linkedList.popBack(), 1);
    });

    test("La lista no debería dejar sacar elementos cuando está vacía", () {
      LinkedList linkedList = LinkedList<int>();
      expect(() => linkedList.popBack(), throwsException);
      expect(() => linkedList.popFront(), throwsException);
    });

    test("addAfter debe agregar elementos después del nodo especificado", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.addAfter(lista.head!, 3);
      expect(lista.popFront(), equals(1));
      expect(lista.popFront(), equals(3));
      expect(lista.popFront(), equals(2));
    });

    test("Cuenta correcta con pushback", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushBack(6);
      lista.pushBack(7);
      lista.pushBack(8);
      lista.pushBack(9);
      lista.pushBack(10);
      expect(lista.size, 10);
    });

    test("Cuenta correcta con pushfront", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushFront(1);
      lista.pushFront(2);
      lista.pushFront(3);
      lista.pushFront(4);
      lista.pushFront(5);
      lista.pushFront(6);
      lista.pushFront(7);
      lista.pushFront(8);
      lista.pushFront(9);
      lista.pushFront(10);
      expect(lista.size, 10);
    });

    test("Cuenta correcta con pushback y pushfront", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushFront(6);
      lista.pushFront(7);
      lista.pushFront(8);
      lista.pushFront(9);
      lista.pushFront(10);
      expect(lista.size, 10);
    });

    test("Cuenta correcta con addAfter", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.addAfter(lista.head!, 6);
      lista.addAfter(lista.head!.next!, 7);
      lista.addAfter(lista.head!.next!.next!, 8);
      lista.addAfter(lista.head!.next!.next!.next!, 9);
      lista.addAfter(lista.head!.next!.next!.next!.next!, 10);
      expect(lista.size, 10);
    });

    test("Cuenta correcta con popBack", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushBack(6);
      lista.pushBack(7);
      lista.pushBack(8);
      lista.pushBack(9);
      lista.pushBack(10);
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      expect(lista.size, 4);
    });

    test("Cuenta correcta con popFront", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushBack(6);
      lista.pushBack(7);
      lista.pushBack(8);
      lista.pushBack(9);
      lista.pushBack(10);
      lista.popFront();
      lista.popFront();
      lista.popFront();
      lista.popFront();
      lista.popFront();
      lista.popFront();
      expect(lista.size, 4);
    });

    test("Cuenta correcta con popBack y popFront", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushFront(6);
      lista.pushFront(7);
      lista.pushFront(8);
      lista.pushFront(9);
      lista.pushFront(10);
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popBack();
      lista.popFront();
      lista.popFront();
      lista.popFront();
      lista.popFront();
      expect(lista.size, 0);
    });

    test("Cuenta correcta con delete", () {
      LinkedList<int> lista = LinkedList<int>();
      lista.pushBack(1);
      lista.pushBack(2);
      lista.pushBack(3);
      lista.pushBack(4);
      lista.pushBack(5);
      lista.pushFront(6);
      lista.pushFront(7);
      lista.pushFront(8);
      lista.pushFront(9);
      lista.pushFront(10);
      lista.delete(7);
      lista.delete(1);
      lista.delete(4);
      lista.delete(3);
      expect(lista.size, 6);
    });

    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () async => pruebaNDatosLinkedList(10000));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () async => pruebaNDatosLinkedList(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () async => pruebaNDatosLinkedList(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () async => pruebaNDatosLinkedList(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () async => pruebaNDatosLinkedList(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () async => pruebaNDatosLinkedList(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () async => pruebaNDatosLinkedList(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () async => pruebaNDatosLinkedList(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () async => pruebaNDatosLinkedList(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () async => pruebaNDatosLinkedList(100000));
  });

  group("Tiempo de inserción, búsqueda y eliminación para String", () {
    test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosLinkedListString(10000));

    test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
        () => pruebaNDatosLinkedListString(20000));

    test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
        () => pruebaNDatosLinkedListString(30000));

    test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
        () => pruebaNDatosLinkedListString(40000));

    test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosLinkedListString(50000));

    test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
        () => pruebaNDatosLinkedListString(60000));

    test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
        () => pruebaNDatosLinkedListString(70000));

    test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
        () => pruebaNDatosLinkedListString(80000));

    test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
        () => pruebaNDatosLinkedListString(90000));

    test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosLinkedListString(100000));

    test("Tiempo de inserción, búsqueda y eliminación de 200000",
        () => pruebaNDatosLinkedListString(200000));

    test("Tiempo de inserción, búsqueda y eliminación de 300000",
        () => pruebaNDatosLinkedListString(300000));

    test("Tiempo de inserción, búsqueda y eliminación de 400000",
        () => pruebaNDatosLinkedListString(400000));

    test("Tiempo de inserción, búsqueda y eliminación de 500000",
        () => pruebaNDatosLinkedListString(500000));

    test("Tiempo de inserción, búsqueda y eliminación de 600000",
        () => pruebaNDatosLinkedListString(600000));

    test("Tiempo de inserción, búsqueda y eliminación de 700000",
        () => pruebaNDatosLinkedListString(700000));

    test("Tiempo de inserción, búsqueda y eliminación de 800000",
        () => pruebaNDatosLinkedListString(800000));
  });
}

pruebaNDatosLinkedList(int N) async {
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

  LinkedList<Palabra> lista = LinkedList<Palabra>();
  List palabras = await getDataFromJson(ruta);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < palabras.length; i++) {
    Map<String, dynamic> json = palabras[i] as Map<String, dynamic>;
    Palabra palabra = Palabra.fromJson(json);
    lista.pushBack(palabra);
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
    Palabra palabra = lista.popBack();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}

pruebaNDatosLinkedListString(int N) {
  print("Prueba con $N datos");
  LinkedList lista = LinkedList<String>();
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    lista.pushBack("Palabra $i");
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
    lista.popBack();
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
