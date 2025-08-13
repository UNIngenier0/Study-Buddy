class Array<T> {
  late List<T?> _elements;
  int _size = 0;

  Array(capacity) {
    _elements = List.filled(capacity, null);
  }

  // Insertar un elemento al final del arreglo
  void insert(T element) {
    _elements[_size++] = element;
  }

  // Buscar un elemento en el arreglo
  bool search(T target) {
    for (int i = 0; i < _size; i++) {
      if (_elements[i] == target) {
        return true;
      }
    }
    return false;
  }

  // Devolver un elemento del arreglo por el final
  T pop() {
    if (_size == 0) {
      throw Exception('El arreglo está vacío');
    }
    return _elements[--_size]!;
  }

  // Eliminar un elemento del arreglo por valor
  void remove(T element) {
    int index = _findIndexOf(element);
    _removeAtIndex(index);
  }

  int _findIndexOf(T element) {
    for (int i = 0; i < _elements.length; i++) {
      if (_elements[i] == element) {
        return i;
      }
    }
    throw Exception('Elemento no encontrado');
  }

  void _removeAtIndex(int index) {
    for (int i = index; i < _size - 1; i++) {
      _elements[i] = _elements[i + 1];
    }
    _size--;
  }

  // Obtener la longitud del arreglo
  int get length => _size;

  // Obtener un elemento en una posición específica
  T? operator [](int index) {
    if (index < 0 || index >= _elements.length) {
      throw RangeError('Índice fuera de rango');
    }
    return _elements[index];
  }

  // Establecer un elemento en una posición específica
  void operator []=(int index, T value) {
    if (index < 0 || index >= _elements.length) {
      throw RangeError('Índice fuera de rango');
    }
    _elements[index] = value;
  }
}
