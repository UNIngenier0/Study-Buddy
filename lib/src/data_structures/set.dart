import 'package:study_buddy/src/services/firestore_service.dart';
import 'package:study_buddy/src/data_structures/linked_list.dart';

class MiSet<T> {
  late List<LinkedList<T>> _buckets;
  late int _capacity;
  int _size = 0;

  // Get para size
  int get size => _size;

  // get para empty
  bool get empty => _size == 0;

  MiSet(int initialCapacity) {
    _capacity = initialCapacity;
    _buckets = List.filled(_capacity, LinkedList<T>());
  }

  int _hash(T value) {
    if (value is String) {
      return _hashString(value);
    } else if (value is int) {
      return _hashInt(value);
    } else if (value is Palabra) {
      return _hashPalabra(value);
    }
    return value.hashCode % _capacity;
  }

  int _hashString(String s) {
    int hashValue = 0;
    const int base =
        31; // Se puede cambiar por cualquier otro número primo mayor a 26

    for (int i = 0; i < s.length; i++) {
      hashValue = (hashValue * base + s.codeUnitAt(i)) % _capacity;
    }

    return hashValue;
  }

  int _hashInt(int n) {
    return n % _capacity;
  }

  int _hashPalabra(Palabra palabra) {
    return (_hashString(palabra.espanol) ^
            _hashString(palabra.ingles) ^
            _hashString(palabra.definicion) ^
            _hashString(palabra.ejemplos[0])) %
        _capacity;
  }

  // Función resize para set dinámico
  void _rehash() {
    double loadFactor = _size / _capacity;
    if (loadFactor >= 0.9) {
      _capacity *= 2;
      var newBuckets = List.filled(_capacity, LinkedList<T>());

      // Rehashing
      for (var bucket in _buckets) {
        for (var element in bucket.getAll()) {
          var index = _hash(element);
          newBuckets[index].pushBack(element);
        }
      }

      _buckets = newBuckets; // Reemplazar el arreglo viejo
    }
  }

  // Insertar un elemento
  void insert(T value) {
    // Revisar si es necesario hacer resize
    if (!contains(value)) {
      _rehash();
      int index = _hash(value);
      _buckets[index].pushBack(value);
      _size++;
    }
  }

  // Eliminar un elemento
  void remove(T value) {
    int index = _hash(value);
    _buckets[index].delete(value);
    _size--;
  }

  // Revisar si un elemento está contenido
  bool contains(T value) {
    int index = _hash(value);
    return _buckets[index].search(value);
  }

  // A lista
  List<T> toList() {
    List<T> list = [];
    for (var bucket in _buckets) {
      for (var element in bucket.getAll()) {
        list.add(element);
      }
    }
    return list;
  }
}
