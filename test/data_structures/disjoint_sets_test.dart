import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/disjoint_sets.dart';

void main() {
  group("Funcionamiento de conjuntos disjuntos", () {
    test("Unión", () {
      DisjointSets disjointSets = DisjointSets(10);
      disjointSets.union(1, 2);
      disjointSets.union(2, 3);
      disjointSets.union(4, 5);
      disjointSets.union(6, 7);

      expect(disjointSets.find(2) == disjointSets.find(3), true);
      expect(disjointSets.find(4) == disjointSets.find(3), false);
    });

    test("Contar elementos de un conjunto", () {
      DisjointSets disjointSets = DisjointSets(10);
      disjointSets.union(1, 2);
      disjointSets.union(2, 3);
      disjointSets.union(4, 5);

      expect(disjointSets.lengthSet(2), 3);
      expect(disjointSets.lengthSet(4), 2);
    });
  });
  group("Tiempo de inserción, búsqueda y eliminación para MaxHeap", () {
    test("Tiempo de inserción,búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosDisjointSets(10000));
    test("Tiempo de inserción,búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosDisjointSets(50000));
    test("Tiempo de inserción,búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosDisjointSets(100000));
    test("Tiempo de inserción,búsqueda y eliminación de 150000 datos",
        () => pruebaNDatosDisjointSets(150000));
    test("Tiempo de inserción,búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosDisjointSets(200000));
    test("Tiempo de inserción,búsqueda y eliminación de 250000 datos",
        () => pruebaNDatosDisjointSets(250000));
    test("Tiempo de inserción,búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosDisjointSets(300000));
    test("Tiempo de inserción,búsqueda y eliminación de 350000 datos",
        () => pruebaNDatosDisjointSets(350000));
    test("Tiempo de inserción,búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosDisjointSets(400000));
    test("Tiempo de inserción,búsqueda y eliminación de 450000 datos",
        () => pruebaNDatosDisjointSets(450000));
    test("Tiempo de inserción,búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosDisjointSets(500000));
  });
}

pruebaNDatosDisjointSets(int N) {
  print("Prueba con $N datos");
  DisjointSets disjointSets = DisjointSets(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    disjointSets.MakeSets(i);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    disjointSets.find(i);
  }
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N - 1; i++) {
    disjointSets.union(i, i + 1);
  }
  stopwatch.stop();
  print("Tiempo de unión: ${stopwatch.elapsedMilliseconds} ms");
}
