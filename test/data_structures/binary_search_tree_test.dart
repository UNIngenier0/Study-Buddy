import 'package:test/test.dart';
import 'package:study_buddy/src/data_structures/binary_search_tree.dart';

void main() {
  group("Prueba de funcionamiento de BST", () {
    test("Se debe poder insertar un elemento en el BST", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      expect(bst.inorder(bst.root), [1, 2, 3, 4]);
    });

    test("Se debe poder eliminar un valor", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      bst.delete(3);

      expect(bst.inorder(bst.root), [1, 2, 4]);
    });

    test("Se debe poder buscar un elemento en el arbol", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      expect(bst.search(3), true);
      expect(bst.search(1), true);
      expect(bst.search(2), true);
      expect(bst.search(4), true);
      expect(bst.search(5), false);
    });

    test("Se debe poder buscar el mínimo", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      expect(bst.minimum(bst.root!).data, 1);
    });

    test("Se debe poder buscar el siguiente", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      expect(bst.next(bst.root!).data, 4);
    });

    test("Se debe poder buscar un rango", () {
      BST bst = BST();
      bst.insert(3);
      bst.insert(1);
      bst.insert(2);
      bst.insert(4);

      expect(bst.rangeSearch(1, 3, bst.root), [1, 2, 3]);
    });
  });

  group("Tiempo de inserción, búsqueda y eliminación para BST", () {
    test("Tiempo de inserción,búsqueda y eliminación de 10000 datos",
        () => pruebaNDatosBST(10000));
    test("Tiempo de inserción,búsqueda y eliminación de 50000 datos",
        () => pruebaNDatosBST(50000));
    test("Tiempo de inserción,búsqueda y eliminación de 100000 datos",
        () => pruebaNDatosBST(100000));
    test("Tiempo de inserción,búsqueda y eliminación de 150000 datos",
        () => pruebaNDatosBST(150000));
    test("Tiempo de inserción,búsquedan  y eliminación de 200000 datos",
        () => pruebaNDatosBST(200000));
    test("Tiempo de inserción,búsqueda y eliminación de 250000 datos",
        () => pruebaNDatosBST(250000));
    test("Tiempo de inserción,búsqueda y eliminación de 300000 datos",
        () => pruebaNDatosBST(300000));
    test("Tiempo de inserción,búsqueda y eliminación de 350000 datos",
        () => pruebaNDatosBST(350000));
    test("Tiempo de inserción,búsqueda y eliminación de 400000 datos",
        () => pruebaNDatosBST(400000));
    test("Tiempo de inserción,búsqueda y eliminación de 450000 datos",
        () => pruebaNDatosBST(450000));
    test("Tiempo de inserción,búsqueda y eliminación de 500000 datos",
        () => pruebaNDatosBST(500000));
  });
}

pruebaNDatosBST(int N) {
  print("Prueba con $N datos");
  BST bst = BST();
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    bst.insert(i);
  }
  stopwatch.stop();
  print("Tiempo de inserción: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  expect(bst.search(N ~/ 2), true);
  expect(bst.search(N + 1), false);
  stopwatch.stop();
  print("Tiempo de búsqueda: ${stopwatch.elapsedMilliseconds} ms");
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < N; i++) {
    bst.delete(i);
  }
  stopwatch.stop();
  print("Tiempo de eliminación: ${stopwatch.elapsedMilliseconds} ms");
}
