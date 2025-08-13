class Queue<T> {
  late int _front, _rear, _count;
  late List<T?> _queue;

  //Constructores
  Queue(int n) {
    _front = 0;
    _rear = 0;
    _count = 0;
    _queue = List<T?>.filled(n, null);
  }

  // Métodos
  bool isEmpty() => _count <= 0;

  bool isFull() => _count >= _queue.length;

  void enqueue(T item) {
    if (isFull()) {
      throw Exception("La cola está llena");
    }
    _queue[_rear] = item;
    _rear = (_rear + 1) % _queue.length;
    _count++;
  }

  T dequeue() {
    if (isEmpty()) {
      throw Exception("La cola está vacía");
    }
    T item = _queue[_front] as T;
    _front = (_front + 1) % _queue.length;
    _count--;
    return item;
  }

  T peek() {
    if (isEmpty()) {
      throw Exception("La cola está vacía");
    }
    T item = _queue[_front] as T;
    return item;
  }

  // Consulta de un dato
  bool search(T target) {
    if (isEmpty()) {
      return false;
    }

    int currentIndex = _front;

    for (int i = 0; i < _count; i++) {
      if (_queue[currentIndex] == target) {
        return true;
      }
      currentIndex = (currentIndex + 1) % _queue.length;
    }

    return false;
  }

  // Consulta de todos los datos
  List<T> getAll() {
    List<T> list = [];
    while (!isEmpty()) {
      list.add(dequeue());
    }
    return list;
  }
}
