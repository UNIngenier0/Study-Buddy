import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/avl_tree.dart';

void main() {
  group("Funcionamiento de AVL", () {
    test("Inserción correcta", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      expect(avl.inorder(avl.root), [1, 2, 3, 4]);
    });

    test("Eliminación correcta", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      avl.delete(3);

      expect(avl.inorder(avl.root), [1, 2, 4]);
    });

    test("Búsqueda correcta", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      expect(avl.search(3), true);
      expect(avl.search(1), true);
      expect(avl.search(2), true);
      expect(avl.search(4), true);
      expect(avl.search(5), false);
    });

    test("Mínimo correcto", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      expect(avl.minimum(avl.root!).data, 1);
    });

    test("Siguiente correcto", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      expect(avl.next(avl.root!).data, 4);
    });

    test("Rango correcto", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      expect(avl.rangeSearch(avl.root!, 1, 3), [1, 2, 3]);
    });

    test("Eliminación de elemento inexistente", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);

      avl.delete(5);

      expect(avl.inorder(avl.root), [1, 2, 3, 4]);
    });

    test("Balanceo correcto", () {
      AVL avl = AVL();
      avl.insert(3);
      avl.insert(1);
      avl.insert(2);
      avl.insert(4);
      avl.insert(5);
      avl.insert(6);
      avl.insert(7);
      avl.insert(16);
      avl.insert(15);
      avl.insert(14);
      avl.insert(13);
      avl.insert(12);
      avl.insert(11);
      avl.insert(10);
      avl.insert(8);
      avl.insert(9);
      expect(avl.root!.data, 7);
    });
  });

  group("Tiempo de inserción, búsqueda y eliminación para AVL", () {
    test("Tiempo de inserción,búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosAVL(10000));
    test("Tiempo de inserción,búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosAVL(50000));
    test("Tiempo de inserción,búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosAVL(100000));
    test("Tiempo de inserción,búsqueda y eliminación de 150000 datos",
        () => pruebaNDatosAVL(150000));
    test("Tiempo de inserción,búsqueda y eliminación de 200000 datos",
        () => pruebaNDatosAVL(200000));
    test("Tiempo de inserción,búsqueda y eliminación de 250000 datos",
        () => pruebaNDatosAVL(250000));
    test("Tiempo de inserción,búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosAVL(300000));
    test("Tiempo de inserción,búsqueda y eliminación de 350000 datos",
        () => pruebaNDatosAVL(350000));
    test("Tiempo de inserción,búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosAVL(400000));
    test("Tiempo de inserción,búsqueda y eliminación de 450000 datos",
        () => pruebaNDatosAVL(450000));
    test("Tiempo de inserción,búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosAVL(500000));
  });
}

pruebaNDatosAVL(int N) {
  print("Prueba con $N datos");
  AVL avl = AVL();
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    avl.insert(i);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(avl.search(N ~/ 2), true);
  expect(avl.search(N + 1), false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    avl.delete(i);
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
