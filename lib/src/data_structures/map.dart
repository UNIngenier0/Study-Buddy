import 'package:study_buddy/src/data_structures/linked_list.dart';
import 'package:study_buddy/src/functions/obtener_palabras.dart';

class MiMap<K, V> {
  int _capacity;
  int _size = 0;
  late List<LinkedList> _buckets;

  // Get para size
  int get size => _size;

  // get para empty
  bool get empty => _size == 0;

  MiMap(this._capacity) {
    _buckets = List.filled(_capacity, LinkedList<List<dynamic>>());
  }

  int _hash(K key) {
    if (key is String) {
      return _hashString(key);
    } else if (key is int) {
      return _hashInt(key);
    } else if (key is Palabra) {
      return _hashPalabra(key);
    }
    return key.hashCode % _capacity;
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

  // Función resize para mapa dinámico
  void _rehash() {
    double loadFactor = _size / _capacity;
    if (loadFactor >= 0.9) {
      _capacity *= 2;
      var newBuckets = List.filled(_capacity, LinkedList<List<dynamic>>());

      // Rehashing
      for (var bucket in _buckets) {
        for (var element in bucket.getAll()) {
          var index = _hash(element[0]);
          newBuckets[index].pushBack(element);
        }
      }

      _buckets = newBuckets; // Reemplazar el arreglo viejo
    }
  }

  // Revisar si existe una llave
  bool hasKey(K key) {
    List bucket = _buckets[_hash(key)].getAll();
    for (List pair in bucket) {
      if (pair[0] == key) {
        return true;
      }
    }
    return false;
  }

  // Get que obtiene el valor de una llave
  V? get(K key, [V? defaultValue]) {
    List bucket = _buckets[_hash(key)].getAll();
    for (List pair in bucket) {
      if (pair[0] == key) {
        return pair[1];
      }
    }
    return defaultValue;
  }

  void set(K key, V value) {
    _rehash(); // Rehash if necessary
    LinkedList bucket = _buckets[_hash(key)]; // Get the bucket
    // Encontrar si ya está la llave paar cambiar el valor
    for (List pair in bucket.getAll()) {
      if (pair[0] == key) {
        pair[1] = value;
        return;
      }
    }
    // Si no está, insertar el par llave-valor
    bucket.pushBack([key, value]);
    _size++;
  }

  // Eliminar una llave
  void remove(K key) {
    LinkedList bucket = _buckets[_hash(key)];
    for (var pair in bucket.getAll()) {
      if (pair[0] == key) {
        bucket.delete(pair);
        _size--;
        return;
      }
    }
  }

  // Lista de llaves
  List<K> keys() {
    List<K> keys = [];
    for (var bucket in _buckets) {
      for (var pair in bucket.getAll()) {
        keys.add(pair[0]);
      }
    }
    return keys;
  }
}
