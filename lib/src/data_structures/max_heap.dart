class MaxHeap {
  int maxSize;
  int size = 0;
  late List<int?> heap;

  MaxHeap(this.maxSize) {
    heap = List<int?>.filled(maxSize, null, growable: false);
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
    while (i > 0 && heap[parent(i)]! < heap[i]!) {
      int aux = heap[parent(i)]!;
      heap[parent(i)] = heap[i];
      heap[i] = aux;
      i = parent(i);
    }
  }

  // Baja un elemento si es menor que alguno de sus hijos
  void siftDown(int i) {
    int maxIndex = i; // Se guardará el elemento mayor entre i y sus hijos
    int _left = left(i);
    if (_left < size && heap[_left]! > heap[maxIndex]!) {
      maxIndex = _left;
    }
    int _right = right(i);
    if (_right < size && heap[_right]! > heap[maxIndex]!) {
      maxIndex = _right;
    }

    // Si el padre es menor que alguno de sus hijos, se intercambian y se continúa recursivamente
    if (i != maxIndex) {
      int aux = heap[i]!;
      heap[i] = heap[maxIndex];
      heap[maxIndex] = aux;
      siftDown(maxIndex);
    }
  }

  void insert(int p) {
    if (size == maxSize) {
      throw Exception("El montículo está lleno");
    }
    heap[size] = p;
    siftUp(size);
    size++;
  }

  int extractMax() {
    if (size <= 0) {
      throw Exception("El montículo está vacío");
    }
    int maximo = heap[0]!;
    heap[0] = heap[size - 1];
    size--;
    siftDown(0);
    return maximo;
  }

  // Elimina el elemento i del montículo
  int remove(int i) {
    if (i < 0 || i >= size) {
      throw Exception("El índice no es válido");
    }
    int eliminado = heap[i]!;
    heap[i] = 100000000000000;
    siftUp(i);
    extractMax();
    return eliminado;
  }

  // Cambia la prioridad del elemento i a p
  void changePriority(int i, int p) {
    if (i < 0 || i >= size) {
      throw Exception("El índice no es válido");
    }
    int anterior = heap[i]!;
    heap[i] = p;
    if (p > anterior) {
      siftUp(i);
    } else {
      siftDown(i);
    }
  }

  bool empty() => size == 0;
}
