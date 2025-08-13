import 'map.dart';
import 'linked_list.dart';

class Grafo<T> {
  late MiMap<T, LinkedList<T>> _adjacencyList;

  Grafo(int longitud) {
    _adjacencyList = MiMap<T, LinkedList<T>>(longitud);
  }

  // Añadir un vértice al grafo
  void addVertex(T vertex) {
    if (!_adjacencyList.hasKey(vertex)) {
      _adjacencyList.set(vertex, LinkedList());
      return;
    }
    throw Exception('El vértice ya existe');
  }

  // Añadir una arista al grafo
  // El grafo será unidireccional, por lo que el vertex1 apuntará al vertex2 pero no viceversa
  void addEdge(T verticeOrigen, T verticeDestino) {
    if (_adjacencyList.hasKey(verticeOrigen) &&
        _adjacencyList.hasKey(verticeDestino)) {
      _adjacencyList.get(verticeOrigen)!.pushBack(verticeDestino);
      return;
    }
    throw Exception('El vértice no existe');
  }

  //Vecinos de un vértice
  LinkedList<T>? getNeighbors(T vertex) {
    if (_adjacencyList.hasKey(vertex)) {
      return _adjacencyList.get(vertex);
    }
    throw Exception('El vértice no existe');
  }

  // Obtener el tamaño del grafo
  int size() {
    return _adjacencyList.size;
  }

  // Obtener el grafo
  MiMap<T, LinkedList<T>> getGraph() {
    return _adjacencyList;
  }

  // Obtener nodos
  List<T> getNodes() {
    return _adjacencyList.keys();
  }

  // Remover un vértice
  void removeVertex(T vertex) {
    if (_adjacencyList.hasKey(vertex)) {
      _adjacencyList.remove(vertex);
      for (var key in _adjacencyList.keys()) {
        _adjacencyList.get(key)!.delete(vertex);
      }
      return;
    }
    throw Exception('El vértice no existe');
  }
}
