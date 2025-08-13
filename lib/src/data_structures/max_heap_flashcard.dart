import 'package:study_buddy/src/services/firestore_service.dart';

class MaxHeap {
  int maxSize;
  int size = 0;
  late List<Flashcard?> heap;

  MaxHeap(this.maxSize) {
    heap = List<Flashcard?>.filled(maxSize, null, growable: false);
  }

  int parent(int i) {
    return (i - 1) ~/ 2;
  }

  int left(int i) {
    return 2 * i + 1;
  }

  int right(int i) {
    return 2 * i + 2;
  }

  // Sube un elemento si es mayor que su padre
  void siftUp(int i) {
    while (i > 0 && heap[parent(i)]!.prioridad < heap[i]!.prioridad) {
      Flashcard aux = heap[parent(i)]!;
      heap[parent(i)] = heap[i];
      heap[i] = aux;
      i = parent(i);
    }
  }

  // Baja un elemento si es menor que alguno de sus hijos
  void siftDown(int i) {
    int maxIndex = i; // Se guardará el elemento mayor entre i y sus hijos
    int _left = left(i);
    if (_left < size && heap[_left]!.prioridad > heap[maxIndex]!.prioridad) {
      maxIndex = _left;
    }
    int _right = right(i);
    if (_right < size && heap[_right]!.prioridad > heap[maxIndex]!.prioridad) {
      maxIndex = _right;
    }

    // Si el padre es menor que alguno de sus hijos, se intercambian y se continúa recursivamente
    if (i != maxIndex) {
      Flashcard aux = heap[i]!;
      heap[i] = heap[maxIndex];
      heap[maxIndex] = aux;
      siftDown(maxIndex);
    }
  }

  void insert(Flashcard p) {
    if (size == maxSize) {
      throw Exception("El montículo está lleno");
    }
    heap[size] = p;
    siftUp(size);
    size++;
  }

  Flashcard extractMax() {
    if (size <= 0) {
      throw Exception("El montículo está vacío");
    }
    Flashcard maximo = heap[0]!;
    heap[0] = heap[size - 1];
    size--;
    siftDown(0);
    return maximo;
  }

  bool empty() => size == 0;

  void heapSort(List<Flashcard> arr) {
    int n = arr.length;

    // Construir un heap máximo
    for (int i = (n ~/ 2) - 1; i >= 0; i--) {
      heapify(arr, n, i);
    }

    // Extraer elementos del heap uno por uno
    for (int i = n - 1; i > 0; i--) {
      // Mover el elemento raíz actual al final del arreglo
      Flashcard temp = arr[0];
      arr[0] = arr[i];
      arr[i] = temp;

      // Llamar a heapify en el montículo reducido
      heapify(arr, i, 0);
    }
  }

// Función para hacer heapify un subárbol en la raíz i
  void heapify(List<Flashcard> arr, int n, int i) {
    int largest = i; // Inicializar el valor más grande como la raíz
    int left = 2 * i + 1; // Índice del hijo izquierdo
    int right = 2 * i + 2; // Índice del hijo derecho

    // Si el hijo izquierdo es más grande que la raíz
    if (left < n && arr[left].prioridad > arr[largest].prioridad) {
      largest = left;
    }

    // Si el hijo derecho es más grande que el más grande hasta ahora
    if (right < n && arr[right].prioridad > arr[largest].prioridad) {
      largest = right;
    }

    // Si el valor más grande no es la raíz
    if (largest != i) {
      Flashcard swap = arr[i];
      arr[i] = arr[largest];
      arr[largest] = swap;

      // Llamar a heapify en el subárbol afectado
      heapify(arr, n, largest);
    }
  }
}
