import 'package:study_buddy/src/services/firestore_service.dart';

class Node {
  Usuario data;
  Node? left;
  Node? right;
  Node? parent;

  Node(this.data) {
    left = null;
    right = null;
    parent = null;
  }
}

class BSTUsuarioTraduccion {
  Node? root;

  BSTUsuarioParejas() {
    root = null;
  }

  // El árbol está vacío
  bool isEmpty() {
    return root == null;
  }

  // El método find devuelve el nodo con un valor igual a "key", si no existe, se devuelve el nodo inmediatamente superior
  Node find(Usuario key, Node? R) {
    if (R == null) {
      throw Exception("El árbol está vacío");
    }
    if (R.data == key) {
      return R;
    }
    if (R.data.tiempoTraduccion! < key.tiempoTraduccion!) {
      return find(key, R.right);
    }
    if (R.left == null) {
      return R;
    }
    return find(key, R.left);
  }

  // El método next devuelve el nodo con un valor inmediatamente siguiente al nodo N
  Node next(Node N) {
    // En caso de que tenga hijo derecho, se devuelve el nodo más a la izquierda del subárbol derecho
    if (N.right != null) {
      return leftDescendant(N.right!);
    }
    // En caso de que no tenga hijo derecho, se devuelve el primer ancestro que sea hijo izquierdo
    return rightAncestor(N);
  }

  Node leftDescendant(Node N) {
    if (N.left == null) {
      return N;
    }
    return leftDescendant(N.left!);
  }

  Node rightAncestor(Node N) {
    if (N.data.tiempoTraduccion! < N.parent!.data.tiempoTraduccion!) {
      return N.parent!;
    }
    return rightAncestor(N.parent!);
  }

  // El método insert inserta un nodo con un valor igual a "key" en el árbol
  void insert(Usuario key) {
    root = _insertRec(root, null, key);
  }

  Node _insertRec(Node? current, Node? parent, Usuario key) {
    if (current == null) {
      current = Node(key);
      current.parent = parent;
      return current;
    }
    if (key.tiempoTraduccion! < current.data.tiempoTraduccion!) {
      current.left = _insertRec(current.left, current, key);
    } else if (key.tiempoTraduccion! > current.data.tiempoTraduccion!) {
      current.right = _insertRec(current.right, current, key);
    }
    return current;
  }

  // El método delete elimina el nodo con un valor igual a "key" del árbol
  void delete(Usuario key) {
    root = _deleteRec(root, key);
  }

  Node? _deleteRec(Node? current, Usuario key) {
    if (current == null) {
      return current;
    }
    if (key.tiempoTraduccion! < current.data.tiempoTraduccion!) {
      current.left = _deleteRec(current.left, key);
    } else if (key.tiempoTraduccion! > current.data.tiempoTraduccion!) {
      current.right = _deleteRec(current.right, key);
    } else {
      if (current.left == null) {
        return current.right;
      } else if (current.right == null) {
        return current.left;
      }
      current.data = minimum(current.right!)
          .data; // Se reemplaza el valor del nodo actual por el valor del nodo más a la izquierda del subárbol derecho
      current.right = _deleteRec(current.right, current.data);
    }
    return current;
  }

  Node minimum(Node R) {
    return leftDescendant(R);
  }

  // El método rangeSearch devuelve una lista de nodos con valores entre "x" y "y"
  List<int> rangeSearch(Usuario x, Usuario y, R) {
    List<int> result = [];
    Node N = find(x, R);
    while (N.data.tiempoTraduccion! <= y.tiempoTraduccion!) {
      if (N.data.tiempoTraduccion! >= x.tiempoTraduccion!) {
        result.add(N.data.tiempoTraduccion!);
      }
      N = next(N);
    }
    return result;
  }

  // El método inorder devuelve una lista con los valores del árbol en orden ascendente
  List<Usuario> inorder(Node? R) {
    List<Usuario> result = [];
    if (R != null) {
      result.addAll(inorder(R.left));
      result.add(R.data);
      result.addAll(inorder(R.right));
    }
    return result;
  }

  // El método search devuelve si un valor está en el árbol
  bool search(Usuario key) {
    Node? current = root;
    while (current != null) {
      if (current.data == key) {
        return true;
      } else if (current.data.tiempoTraduccion! > key.tiempoTraduccion!) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    return false;
  }
}

class BSTUsuarioParejas {
  Node? root;

  BSTUsuarioParejas() {
    root = null;
  }

  // El árbol está vacío
  bool isEmpty() {
    return root == null;
  }

  // El método find devuelve el nodo con un valor igual a "key", si no existe, se devuelve el nodo inmediatamente superior
  Node find(Usuario key, Node? R) {
    if (R == null) {
      throw Exception("El árbol está vacío");
    }
    if (R.data == key) {
      return R;
    }
    if (R.data.tiempoParejas! < key.tiempoParejas!) {
      return find(key, R.right);
    }
    if (R.left == null) {
      return R;
    }
    return find(key, R.left);
  }

  // El método next devuelve el nodo con un valor inmediatamente siguiente al nodo N
  Node next(Node N) {
    // En caso de que tenga hijo derecho, se devuelve el nodo más a la izquierda del subárbol derecho
    if (N.right != null) {
      return leftDescendant(N.right!);
    }
    // En caso de que no tenga hijo derecho, se devuelve el primer ancestro que sea hijo izquierdo
    return rightAncestor(N);
  }

  Node leftDescendant(Node N) {
    if (N.left == null) {
      return N;
    }
    return leftDescendant(N.left!);
  }

  Node rightAncestor(Node N) {
    if (N.data.tiempoParejas! < N.parent!.data.tiempoParejas!) {
      return N.parent!;
    }
    return rightAncestor(N.parent!);
  }

  // El método insert inserta un nodo con un valor igual a "key" en el árbol
  void insert(Usuario key) {
    root = _insertRec(root, null, key);
  }

  Node _insertRec(Node? current, Node? parent, Usuario key) {
    if (current == null) {
      current = Node(key);
      current.parent = parent;
      return current;
    }
    if (key.tiempoParejas! < current.data.tiempoParejas!) {
      current.left = _insertRec(current.left, current, key);
    } else if (key.tiempoParejas! > current.data.tiempoParejas!) {
      current.right = _insertRec(current.right, current, key);
    }
    return current;
  }

  // El método delete elimina el nodo con un valor igual a "key" del árbol
  void delete(Usuario key) {
    root = _deleteRec(root, key);
  }

  Node? _deleteRec(Node? current, Usuario key) {
    if (current == null) {
      return current;
    }
    if (key.tiempoParejas! < current.data.tiempoParejas!) {
      current.left = _deleteRec(current.left, key);
    } else if (key.tiempoParejas! > current.data.tiempoParejas!) {
      current.right = _deleteRec(current.right, key);
    } else {
      if (current.left == null) {
        return current.right;
      } else if (current.right == null) {
        return current.left;
      }
      current.data = minimum(current.right!)
          .data; // Se reemplaza el valor del nodo actual por el valor del nodo más a la izquierda del subárbol derecho
      current.right = _deleteRec(current.right, current.data);
    }
    return current;
  }

  Node minimum(Node R) {
    return leftDescendant(R);
  }

  // El método rangeSearch devuelve una lista de nodos con valores entre "x" y "y"
  List<int> rangeSearch(Usuario x, Usuario y, R) {
    List<int> result = [];
    Node N = find(x, R);
    while (N.data.tiempoParejas! <= y.tiempoParejas!) {
      if (N.data.tiempoParejas! >= x.tiempoParejas!) {
        result.add(N.data.tiempoParejas!);
      }
      N = next(N);
    }
    return result;
  }

  // El método inorder devuelve una lista con los valores del árbol en orden ascendente
  List<Usuario> inorder(Node? R) {
    List<Usuario> result = [];
    if (R != null) {
      result.addAll(inorder(R.left));
      result.add(R.data);
      result.addAll(inorder(R.right));
    }
    return result;
  }

  // El método search devuelve si un valor está en el árbol
  bool search(Usuario key) {
    Node? current = root;
    while (current != null) {
      if (current.data == key) {
        return true;
      } else if (current.data.tiempoParejas! > key.tiempoParejas!) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    return false;
  }
}
