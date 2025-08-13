// Lista simplemente enlazada

class Node<T> {
  late T key;
  Node<T>? next;
  Node(T value) {
    key = value;
  }
}

class LinkedList<T> {
  Node<T>? head, tail;
  int _size = 0;

  //Constructor
  LinkedList() {
    head = null;
    tail = null;
  }

  //Getters
  int get size => _size;

  //Métodos

  //Inserción de un dato
  void pushFront(T value) {
    Node<T> nuevo = Node<T>(value);
    nuevo.next = head;
    head = nuevo;
    tail ??=
        head; //Si la cola estaba null, se coloca apuntando a la misma cabeza
    _size++;
  }

  void pushBack(T item) {
    Node<T> nuevo = Node(item);
    if (tail == null) {
      head = nuevo;
      tail = nuevo;
    } else {
      tail!.next = nuevo;
      tail = nuevo;
    }
    _size++;
  }

  // Eliminación de un dato al inicio o final

  T popFront() {
    if (head == null) {
      throw Exception("La lista enlazada está vacía");
    }

    Node<T> dev = head!;
    head = head!.next;
    if (head == null) {
      tail == null;
    }
    _size--;
    return dev.key;
  }

  T popBack() {
    late Node<T> dev;

    if (head == null) {
      throw Exception("La lista enlazada está vacía");
    }
    if (head == tail) {
      dev = head!;
      head = null;
      tail = null;
    } else {
      Node<T> p = head!;
      while (p.next!.next != null) {
        p = p.next!;
      }
      dev = p.next!;
      p.next = null;
      tail = p;
    }
    _size--;
    return dev.key;
  }

  void addAfter(node, key) {
    Node<T> node2 = Node(key);
    node2.next = node.next;
    node.next = node2;
    if (tail == node) {
      tail == node2;
    }
    _size++;
  }

  // Actualización de un dato
  void update(T oldData, T newData) {
    if (head == null) throw Exception("La lista enlazada está vacía");

    bool encontrado = false;

    Node<T>? current = head!;
    while (current != null) {
      if (current.key == oldData) {
        current.key = newData;
        encontrado = true;
        break;
      }
      current = current.next;
    }

    if (!encontrado) throw Exception("El dato no existe");
  }

  // Eliminación de un solo dato
  void delete(T data) {
    if (head == null) throw Exception("La lista enlazada está vacía");

    if (head!.key == data) {
      head = head!.next;
      _size--;
      return;
    }

    bool encontrado = false;

    Node<T>? current = head;
    Node<T>? prev = head!;
    while (current != null) {
      if (current.key == data) {
        prev!.next = current.next;
        encontrado = true;
        _size--;
        return;
      }
      prev = current;
      current = current.next;
    }
    if (!encontrado) throw Exception("El dato no existe");
  }

  // Búsqueda de un solo dato
  bool search(T data) {
    Node<T>? current = head;
    while (current != null) {
      if (current.key == data) {
        return true;
      }
      current = current.next;
    }
    return false;
  }

  // Consulta de todos los datos
  List<T> getAll() {
    var current = head;
    final dataList = <T>[];
    while (current != null) {
      dataList.add(current.key);
      current = current.next;
    }
    return dataList;
  }
}
