// ignore_for_file: file_names

class Node {
  int data;
  Node? left;
  Node? right;
  Node? parent;
  int height = 0;
  Node(this.data) {
    left = null;
    right = null;
    parent = null;
  }
}

class AVL {
  Node? root;

  int _max(int a, int b) {
    return (a > b) ? a : b;
  }

  int _getHeight(Node? node) {
    if (node == null) {
      return 0;
    }
    return node.height;
  }

  int _getBalance(Node? node) {
    if (node == null) {
      return 0;
    }
    return _getHeight(node.left) - _getHeight(node.right);
  }

  Node? rightRotate(Node y) {
    Node x = y.left!;
    Node? T2 = x.right;

    x.right = y;
    y.left = T2;

    y.height = _max(_getHeight(y.left), _getHeight(y.right)) + 1;
    x.height = _max(_getHeight(x.left), _getHeight(x.right)) + 1;

    return x;
  }

  Node? leftRotate(Node x) {
    Node y = x.right!;
    Node? T2 = y.left;

    y.left = x;
    x.right = T2;

    x.height = _max(_getHeight(x.left), _getHeight(x.right)) + 1;
    y.height = _max(_getHeight(y.left), _getHeight(y.right)) + 1;

    return y;
  }

  Node? insBalanceado(Node? node, int data) {
    if (node == null) {
      return Node(data);
    }

    if (data < node.data) {
      node.left = insBalanceado(node.left, data);
    } else if (data > node.data) {
      node.right = insBalanceado(node.right, data);
    } else {
      // Si el valor ya existe, no se inserta nuevamente.
      return node;
    }

    node.height = _max(_getHeight(node.left), _getHeight(node.right)) + 1;

    int balance = _getBalance(node);

    // Casos de rotación
    if (balance > 1 && data < node.left!.data) {
      return rightRotate(node);
    }

    if (balance < -1 && data > node.right!.data) {
      return leftRotate(node);
    }

    if (balance > 1 && data > node.left!.data) {
      node.left = leftRotate(node.left!);
      return rightRotate(node);
    }

    if (balance < -1 && data < node.right!.data) {
      node.right = rightRotate(node.right!);
      return leftRotate(node);
    }

    return node;
  }

  // Método de inserción pública
  void insert(int data) {
    root = insBalanceado(root, data)!;
  }

  Node? deleteNode(Node? root, int key) {
    if (root == null) {
      return root;
    }

    if (key < root.data) {
      root.left = deleteNode(root.left, key);
    } else if (key > root.data) {
      root.right = deleteNode(root.right, key);
    } else {
      if (root.left == null || root.right == null) {
        Node? temp = (root.left != null) ? root.left : root.right;

        if (temp == null) {
          temp = root;
          root = null;
        } else {
          root = temp;
        }
      } else {
        Node? temp = minValueNode(root.right!);
        root.data = temp!.data;
        root.right = deleteNode(root.right, temp.data);
      }
    }

    if (root == null) {
      return root;
    }

    root.height = _max(_getHeight(root.left), _getHeight(root.right)) + 1;

    int balance = _getBalance(root);

    if (balance > 1 && _getBalance(root.left) >= 0) {
      return rightRotate(root);
    }

    if (balance > 1 && _getBalance(root.left) < 0) {
      root.left = leftRotate(root.left!);
      return rightRotate(root);
    }

    if (balance < -1 && _getBalance(root.right) <= 0) {
      return leftRotate(root);
    }

    if (balance < -1 && _getBalance(root.right) > 0) {
      root.right = rightRotate(root.right!);
      return leftRotate(root);
    }

    return root;
  }

  Node? minValueNode(Node node) {
    Node current = node;
    while (current.left != null) {
      current = current.left!;
    }
    return current;
  }

  void delete(int data) {
    root = deleteNode(root, data);
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

  Node minimum(Node R) {
    return leftDescendant(R);
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

  // El método rangeSearch devuelve una lista de nodos con valores entre "x" y "y"
  List<int> rangeSearch(Node R, int x, int y) {
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
  List<int> inorder(Node? R) {
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

  // Levelorder
  List<int> levelorder() {
    List<int> result = [];
    List<Node?> queue = [];
    queue.add(root);
    while (queue.isNotEmpty) {
      Node? current = queue.removeAt(0);
      if (current != null) {
        result.add(current.data);
        queue.add(current.left);
        queue.add(current.right);
      }
    }
    return result;
  }
}
