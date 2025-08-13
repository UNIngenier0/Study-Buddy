import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/max_heap.dart';

void main() {
  group("Funcionamiento de max heap", () {
    test("Inserción correcta de elementos", () {
      MaxHeap heap = MaxHeap(10);
      heap.insert(2);
      heap.insert(3);
      heap.insert(1);
      heap.insert(5);
      heap.insert(4);
      heap.insert(6);

      expect(heap.extractMax(), 6);
      expect(heap.extractMax(), 5);
      expect(heap.extractMax(), 4);
      expect(heap.extractMax(), 3);
      expect(heap.extractMax(), 2);
      expect(heap.extractMax(), 1);
    });

    test("No deja extraer si  está vacía", () {
      MaxHeap heap = MaxHeap(10);
      expect(() => heap.extractMax(), throwsException);
    });
    test("Cambia la prioridad de un elemento", () {
      MaxHeap heap = MaxHeap(10);
      heap.insert(2);
      heap.insert(3);
      heap.insert(1);
      heap.insert(5);
      heap.insert(4);
      heap.insert(6);

      heap.changePriority(
          3, 10); // Cambia la prioridad del elemento en el índice 3 a 10
      expect(heap.extractMax(), 10);
      expect(heap.extractMax(), 6);
      expect(heap.extractMax(), 5);
      expect(heap.extractMax(), 4);
      expect(heap.extractMax(), 3);
      expect(heap.extractMax(), 1);
    });

    test("Remueve un elemento", () {
      MaxHeap heap = MaxHeap(10);
      heap.insert(2);
      heap.insert(3);
      heap.insert(1);
      heap.insert(5);

      heap.remove(2); // Elimina el elemento en el índice 2

      expect(heap.extractMax(), 5);
      expect(heap.extractMax(), 3);
      expect(heap.extractMax(), 2);
    });
  });
  group("Tiempo de inserción, búsqueda y eliminación para MaxHeap", () {
    test("Tiempo de inserción,búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosHeap(10000));
    test("Tiempo de inserción,búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosHeap(50000));
    test("Tiempo de inserción,búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosHeap(100000));
    test("Tiempo de inserción,búsqueda y eliminación de 150000 datos",
        () => pruebaNDatosHeap(150000));
    test("Tiempo de inserción,búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosHeap(200000));
    test("Tiempo de inserción,búsqueda y eliminación de 250000 datos",
        () => pruebaNDatosHeap(250000));
    test("Tiempo de inserción,búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosHeap(300000));
    test("Tiempo de inserción,búsqueda y eliminación de 350000 datos",
        () => pruebaNDatosHeap(350000));
    test("Tiempo de inserción,búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosHeap(400000));
    test("Tiempo de inserción,búsqueda y eliminación de 450000 datos",
        () => pruebaNDatosHeap(450000));
    test("Tiempo de inserción,búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosHeap(500000));
  });
}

pruebaNDatosHeap(int N) {
  print("Prueba con $N datos");
  MaxHeap heap = MaxHeap(N);
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    heap.insert(i);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();

  List<int> indicesToRemove = List<int>.generate(N - 1, (i) => i);
  stopwatch.start();
  indicesToRemove.sort((a, b) => b.compareTo(a));
  for (int i in indicesToRemove) {
    heap.remove(i);
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
