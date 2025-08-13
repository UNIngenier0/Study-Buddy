import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/graph.dart';

void main() {
  group("Funcionamiento de grafos", () {
    test("Inserción de nodos", () {
      Grafo<String> grafo = Grafo(10);
      grafo.addVertex("A");
      grafo.addVertex("B");
      grafo.addVertex("C");
      grafo.addVertex("D");
      grafo.addVertex("E");
      grafo.addVertex("F");
      grafo.addVertex("G");
      grafo.addVertex("H");
      grafo.addVertex("I");
      grafo.addVertex("J");

      expect(grafo.size(), 10);
    });

    test("Inserción de vértices", () {
      Grafo<String> grafo = Grafo(10);
      grafo.addVertex("A");
      grafo.addVertex("B");
      grafo.addVertex("C");
      grafo.addVertex("D");
      grafo.addVertex("E");
      grafo.addVertex("F");
      grafo.addVertex("G");
      grafo.addVertex("H");
      grafo.addVertex("I");
      grafo.addVertex("J");

      grafo.addEdge("A", "B");
      grafo.addEdge("A", "C");
      grafo.addEdge("A", "D");
      grafo.addEdge("B", "E");
      grafo.addEdge("B", "F");
      grafo.addEdge("C", "G");
      grafo.addEdge("C", "H");
      grafo.addEdge("D", "I");
      grafo.addEdge("D", "J");

      expect(grafo.getNeighbors("A")!.size, 3);
      expect(grafo.getNeighbors("B")!.size, 2);
      expect(grafo.getNeighbors("C")!.size, 2);
      expect(grafo.getNeighbors("D")!.size, 2);
      expect(grafo.getNeighbors("E")!.size, 0);
      expect(grafo.getNeighbors("F")!.size, 0);
      expect(grafo.getNeighbors("G")!.size, 0);
      expect(grafo.getNeighbors("H")!.size, 0);
      expect(grafo.getNeighbors("I")!.size, 0);
      expect(grafo.getNeighbors("J")!.size, 0);
    });

    test("Existencia de nodos", () {
      Grafo<String> grafo = Grafo(10);
      grafo.addVertex("A");
      grafo.addVertex("B");
      grafo.addVertex("C");
      grafo.addVertex("D");
      grafo.addVertex("E");
      grafo.addVertex("F");
      grafo.addVertex("G");
      grafo.addVertex("H");
      grafo.addVertex("I");
      grafo.addVertex("J");

      grafo.addEdge("A", "B");
      grafo.addEdge("A", "C");
      grafo.addEdge("A", "D");
      grafo.addEdge("B", "E");
      grafo.addEdge("B", "F");
      grafo.addEdge("C", "G");
      grafo.addEdge("C", "H");
      grafo.addEdge("D", "I");
      grafo.addEdge("D", "J");

      expect(grafo.getNodes().contains("A"), true);
      expect(grafo.getNodes().contains("B"), true);
      expect(grafo.getNodes().contains("C"), true);
      expect(grafo.getNodes().contains("D"), true);
      expect(grafo.getNodes().contains("E"), true);
      expect(grafo.getNodes().contains("F"), true);
      expect(grafo.getNodes().contains("G"), true);
      expect(grafo.getNodes().contains("H"), true);
      expect(grafo.getNodes().contains("I"), true);
      expect(grafo.getNodes().contains("J"), true);
      expect(grafo.getNodes().contains("K"), false);
    });

    test("No se puede ingresar un nodo ya existente", () {
      Grafo<String> grafo = Grafo(10);
      grafo.addVertex("A");
      grafo.addVertex("B");

      expect(() => grafo.addVertex("A"), throwsException);
    });

    group("Tiempo de inserción, búsqueda y eliminación", () {
      test("Tiempo de inserción, búsqueda y eliminación de 10000 datos",
          () => pruebaNDatosGrafos(6));

      test("Tiempo de inserción, búsqueda y eliminación de 20000 datos",
          () => pruebaNDatosGrafos(20000));

      test("Tiempo de inserción, búsqueda y eliminación de 30000 datos",
          () => pruebaNDatosGrafos(30000));

      test("Tiempo de inserción, búsqueda y eliminación de 40000 datos",
          () => pruebaNDatosGrafos(40000));

      test("Tiempo de inserción, búsqueda y eliminación de 50000 datos",
          () => pruebaNDatosGrafos(50000));

      test("Tiempo de inserción, búsqueda y eliminación de 60000 datos",
          () => pruebaNDatosGrafos(60000));

      test("Tiempo de inserción, búsqueda y eliminación de 70000 datos",
          () => pruebaNDatosGrafos(70000));

      test("Tiempo de inserción, búsqueda y eliminación de 80000 datos",
          () => pruebaNDatosGrafos(80000));

      test("Tiempo de inserción, búsqueda y eliminación de 90000 datos",
          () => pruebaNDatosGrafos(90000));

      test("Tiempo de inserción, búsqueda y eliminación de 100000 datos",
          () => pruebaNDatosGrafos(100000));

      test("Tiempo de inserción, búsqueda y eliminación de 200000 datos",
          () => pruebaNDatosGrafos(200000));

      test("Tiempo de inserción, búsqueda y eliminación de 300000 datos",
          () => pruebaNDatosGrafos(300000));

      test("Tiempo de inserción, búsqueda y eliminación de 400000 datos",
          () => pruebaNDatosGrafos(400000));

      test("Tiempo de inserción, búsqueda y eliminación de 500000 datos",
          () => pruebaNDatosGrafos(500000));

      test("Tiempo de inserción, búsqueda y eliminación de 600000 datos",
          () => pruebaNDatosGrafos(600000));

      test("Tiempo de inserción, búsqueda y eliminación de 700000 datos",
          () => pruebaNDatosGrafos(700000));

      test("Tiempo de inserción, búsqueda y eliminación de 800000 datos",
          () => pruebaNDatosGrafos(800000));
    });
  });
}

pruebaNDatosGrafos(int N) {
  print("Prueba con $N datos");
  Grafo<String> grafo = Grafo(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    grafo.addVertex("A$i");
  }
  stopwatch.stop();
  print("Tiempo de inserción de nodos: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();

  for (int i = 0; i < N; i = i + 2) {
    grafo.addEdge("A$i", "A${i + 1}");
  }
  stopwatch.stop();
  print("Tiempo de inserción de aristas: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  print(grafo.getNodes());
  stopwatch.start();
  expect(grafo.getNodes().contains("A${N ~/ 2}"), true);
  expect(grafo.getNodes().contains("A${N + 1}"), false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N - 1; i++) {
    grafo.removeVertex("A$i");
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
