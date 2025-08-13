class Node {
  int data;
  Node? parent;
  Node? left;
  Node? right;

  Node(this.data) {
    left = null;
    right = null;
  }
}

class BST {
  Node? root;

  BST() {
    root = null;
  }

  // El árbol está vacío
  bool isEmpty() {
    return root == null;
  }

  // El método find devuelve el nodo con un valor igual a "key", si no existe, se devuelve el nodo inmediatamente superior
  Node find(int key, Node? R) {
    if (R == null) {
      throw Exception("El árbol está vacío");
    }
    if (R.data == key) {
      return R;
    }
    if (R.data < key) {
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
    if (N.data < N.parent!.data) {
      return N.parent!;
    }
    return rightAncestor(N.parent!);
  }
/*
  // El método insert inserta un nodo con un valor igual a "key" en el árbol
  void insert(int key) {
    root = _insertRec(root, null, key);
  }

  Node _insertRec(Node? current, Node? parent, int key) {
    if (current == null) {
      current = Node(key);
      current.parent = parent;
      return current;
    }
    if (key < current.data) {
      current.left = _insertRec(current.left, current, key);
    } else if (key > current.data) {
      current.right = _insertRec(current.right, current, key);
    }
    return current;
  }*/

  void insert(int key) {
    Node? node = Node(key);
    Node? parent = null;
    Node? current = root;

    while (current != null) {
      parent = current;
      if (key < current.data) {
        current = current.left;
        if (current == null) {
          parent.left = node;
          node.parent = parent;
          break;
        }
      } else {
        current = current.right;
        if (current == null) {
          parent.right = node;
          node.parent = parent;
          break;
        }
      }
    }

    if (root == null) {
      root = node;
    }
  }

  // El método delete elimina el nodo con un valor igual a "key" del árbol
  void delete(int key) {
    root = _deleteRec(root, key);
  }

  Node? _deleteRec(Node? current, int key) {
    if (current == null) {
      return current;
    }
    if (key < current.data) {
      current.left = _deleteRec(current.left, key);
    } else if (key > current.data) {
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
  List<int> rangeSearch(x, y, R) {
    List<int> result = [];
    Node N = find(x, R);
    while (N.data <= y) {
      if (N.data >= x) {
        result.add(N.data);
      }
      N = next(N);
    }
    return result;
  }

  // El método inorder devuelve una lista con los valores del árbol en orden ascendente
  List<int> inorder(R) {
    List<int> result = [];
    if (R != null) {
      result.addAll(inorder(R.left));
      result.add(R.data);
      result.addAll(inorder(R.right));
    }
    return result;
  }

  // El método search devuelve si un valor está en el árbol
  bool search(int key) {
    Node? current = root;
    while (current != null) {
      if (current.data == key) {
        return true;
      } else if (current.data > key) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    return false;
  }
}
