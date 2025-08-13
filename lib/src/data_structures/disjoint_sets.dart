class DisjointSets {
  late List<int?> padres;
  late List<int> rango;

  DisjointSets(int N) {
    padres = List<int?>.filled(N, null, growable: false);
    rango = List<int>.filled(N, 0, growable: false);
    for (int i = 0; i < N; i++) {
      MakeSets(i);
    }
  }

  void MakeSets(int i) {
    padres[i] = i; // Cada elemento es su propio padre
  }

  // Busca el conjunto al que pertenece el elemento i
  int find(int i) {
    if (i != padres[i]) {
      padres[i] = find(padres[i]!);
    }
    return padres[i]!;
  }

  // Une los conjuntos a los que pertenecen los elementos i y j
  void union(int i, int j) {
    int iId = find(i);
    int jId = find(j);

    if (iId == jId) return; // Ya estan en el mismo conjunto

    if (rango[iId] > rango[jId]) {
      padres[jId] = iId;
    } else {
      padres[iId] = jId;
      if (rango[iId] == rango[jId]) {
        rango[jId]++;
      }
    }
  }

  // Encuentra la longitud del conjunto al que pertenece el elemento i
  int lengthSet(int i) {
    int iId = find(i);
    int count = 0;
    for (int j = 0; j < padres.length; j++) {
      if (find(j) == iId) {
        count++;
      }
    }
    return count;
  }
}
