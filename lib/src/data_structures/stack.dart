class Stack<T> {
  late int _top;
  late List<T?> _stack;

  //Constructores
  Stack(int n) {
    _top = 0;
    _stack = List<T?>.filled(n, null);
  }

  bool isEmpty() => _top <= 0;

  bool isFull() => _top >= _stack.length;

  T pop() {
    if (isEmpty()) {
      throw Exception("La pila está vacía");
    }
    _top--;
    return _stack[_top]!;
  }

  T peek() {
    if (isEmpty()) {
      throw Exception("La pila está vacía");
    }
    return _stack[_top - 1]!;
  }

  void push(T item) {
    if (isFull()) {
      throw Exception("La pila está llena");
    }
    _stack[_top] = item;
    _top++;
  }

  // Consulta de un dato
  bool search(T item) {
    bool found = false;
    int i = 0;
    while (i < _top && !found) {
      if (_stack[i] == item) {
        found = true;
      }
      i++;
    }
    return found;
  }

  List<T> getAll() {
    List<T> list = [];
    while (!isEmpty()) {
      list.add(pop());
    }
    return list;
  }
}
