import 'dart:collection';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Referencia a la coleccion de usuarios
  late final CollectionReference _usersCollectionRef = _db.collection('users');

  Future<void> createUser(String id, String usuario) async {
    try {
      await _usersCollectionRef.doc(id).set({'usuario': usuario});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersCollectionRef.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Función para obtener el nombre de usuario
  Future<String> getUser(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _usersCollectionRef.doc(id).get();
      return documentSnapshot.get('usuario');
    } catch (e) {
      rethrow;
    }
  }

  // Función para actualizar el nombre de usuario
  Future<void> updateUser(String id, String usuario) async {
    try {
      await _usersCollectionRef.doc(id).update({'usuario': usuario});
    } catch (e) {
      rethrow;
    }
  }

  // Función para agregar un error a la lista de errores
  Future<void> agregarError(String idUsuario, String idPalabra) async {
    try {
      await _usersCollectionRef.doc(idUsuario).update({
        'errores': FieldValue.arrayUnion([idPalabra])
      });
    } catch (e) {
      rethrow;
    }
  }

  // Función para obtener la lista de errores
  Future<List<Palabra>> obtenerErrores(String idUsuario) async {
    try {
      List<Palabra> erroresPalabra = [];

      DocumentSnapshot documentSnapshot =
          await _usersCollectionRef.doc(idUsuario).get();

      if (documentSnapshot.exists) {
        List<String> errores = List.from(documentSnapshot.get('errores'));
        for (String id in errores) {
          DocumentSnapshot palabraData =
              await _db.collection('palabras').doc(id).get();
          if (palabraData.exists) {
            erroresPalabra.add(Palabra.fromFirestore2(palabraData, null));
          }
        }
      }

      return erroresPalabra;
    } catch (e) {
      rethrow;
    }
  }

  // Función para obtener las flashcards de un usuario
  Future<List<Flashcard>> obtenerFlashcard(String idUsuario) async {
    // try {
    List<Flashcard> flashcards = [];

    QuerySnapshot querySnapshot =
        await _usersCollectionRef.doc(idUsuario).collection('flashcards').get();

    for (QueryDocumentSnapshot flashcard in querySnapshot.docs) {
      flashcards.add(Flashcard.fromFirestore(flashcard, null));
    }

    return flashcards;
    // } catch (e) {
    //   rethrow;
    // }
  }

  // Guardar flashcards
  Future<void> guardarFlashcard(String idUsuario, Flashcard flashcard) async {
    try {
      await _usersCollectionRef
          .doc(idUsuario)
          .collection('flashcards')
          .add(flashcard.toFirestore());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> guardarTiempo(String idUsuario, int tiempo) async {
    try {
      await _usersCollectionRef.doc(idUsuario).update({
        'tiempoTraduccion': tiempo,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> guardarTiempoParejas(String idUsuario, int tiempo) async {
    try {
      await _usersCollectionRef.doc(idUsuario).update({
        'tiempoParejas': tiempo,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Usuario>> obtenerUsuarios() async {
    try {
      QuerySnapshot querySnapshot = await _usersCollectionRef.get();
      List<Usuario> usuarios = querySnapshot.docs.map((value) {
        return Usuario.fromFirestore(value, null);
      }).toList();
      return usuarios;
    } catch (e) {
      rethrow;
    }
  }

  // Obtener un usuario
  Future<Usuario> obtenerUsuario(String idUsuario) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _usersCollectionRef.doc(idUsuario).get();
      return Usuario.fromFirestore2(documentSnapshot, null);
    } catch (e) {
      rethrow;
    }
  }

  // Seguidos de un usuario
  Future<List<String>> obtenerSeguidos(String idUsuario) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _usersCollectionRef.doc(idUsuario).get();

      HashMap<String, dynamic> data =
          documentSnapshot.data() as HashMap<String, dynamic>;

      // Verificar si el campo 'siguiendo' existe en el documento
      if (data.containsKey('siguiendo')) {
        List<String> siguiendo = List.from(documentSnapshot.get('siguiendo'));
        return siguiendo;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Seguidos de seguidos
  Future<List<Usuario>> obtenerSeguidosDeSeguidos(String idUsuario) async {
    try {
      List<Usuario> seguidosDeSeguidos = [];
      List<String> seguidos = await obtenerSeguidos(idUsuario);

      for (String id in seguidos) {
        List<String> seguidosDeSeguidosId = await obtenerSeguidos(id);
        for (String id in seguidosDeSeguidosId) {
          seguidosDeSeguidos.add(await obtenerUsuario(id));
        }
      }

      return seguidosDeSeguidos;
    } catch (e) {
      rethrow;
    }
  }

  // Seguir a un usuario
  Future<void> seguirUsuario(String idUsuario, String idSeguido) async {
    try {
      await _usersCollectionRef.doc(idUsuario).update({
        'siguiendo': FieldValue.arrayUnion([idSeguido])
      });
      await _usersCollectionRef.doc(idSeguido).update({
        'seguidores': FieldValue.arrayUnion([idUsuario])
      });
    } catch (e) {
      rethrow;
    }
  }

  // Dejar de seguir usuario
  Future<void> dejarSeguirUsuario(String idUsuario, String idSeguido) async {
    try {
      await _usersCollectionRef.doc(idUsuario).update({
        'siguiendo': FieldValue.arrayRemove([idSeguido])
      });
      await _usersCollectionRef.doc(idSeguido).update({
        'seguidores': FieldValue.arrayRemove([idUsuario])
      });
    } catch (e) {
      rethrow;
    }
  }

  // Referencia a la coleccion de palabras
  late final CollectionReference _palabrasCollectionRef =
      _db.collection('palabras');

  Future<void> createPalabra(Palabra palabra) async {
    await _palabrasCollectionRef.add(palabra);
  }

  Future<List<Palabra>> getPalabras() async {
    try {
      QuerySnapshot querySnapshot = await _palabrasCollectionRef.get();

      List<Palabra> palabras = querySnapshot.docs.map((value) {
        return Palabra.fromFirestore(value, null);
      }).toList();
      return palabras;
    } catch (e) {
      rethrow;
    }
  }

  // Función para cargar las palabras desde un archivo JSON
  Future<List<Palabra>> cargarPalabrasFromJson() async {
    String jsonString =
        await rootBundle.loadString('assets/json/datos_prueba.json');

    List<dynamic> jsonData = json.decode(jsonString);
    List<Palabra> palabras = jsonData.map((e) => Palabra.fromJson(e)).toList();
    return palabras;
  }
}

class Palabra {
  String ingles;
  String espanol;
  List<String> ejemplos;
  String definicion;
  String id;
  String categoria;

  Palabra(
      this.espanol, this.ingles, this.definicion, this.ejemplos, this.categoria,
      {this.id = ""});

  factory Palabra.fromFirestore(
      QueryDocumentSnapshot<Object?> snapshot, SnapshotOptions? options) {
    if (snapshot is QueryDocumentSnapshot<Map<String, dynamic>>) {
      final data = snapshot.data();

      return Palabra(
        data['espanol'],
        data['ingles'],
        data['definicion'],
        data['ejemplos'] is Iterable
            ? List.from(data['ejemplos'])
            : throw Exception(
                "Fallo al obtener los ejemplos",
              ),
        data['categoria'],
        id: snapshot.id,
      );
    }
    throw Exception("Se están cargando valores erróneos");
  }

  factory Palabra.fromFirestore2(
      DocumentSnapshot snapshot, SnapshotOptions? options) {
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      final data = snapshot.data();

      return Palabra(
        data!['espanol'],
        data['ingles'],
        data['definicion'],
        data['ejemplos'] is Iterable
            ? List.from(data['ejemplos'])
            : throw Exception("Fallo al obtener los ejemplos"),
        data['categoria'],
        id: snapshot.id,
      );
    }
    throw Exception("Se están cargando valores erróneos");
  }

  Map<String, dynamic> toFirestore() {
    return {
      'espanol': espanol,
      'ingles': ingles,
      'definicion': definicion,
      'ejemplos': ejemplos,
      'categoria': categoria,
    };
  }

  // Función para comparar listas por contenido
  bool listEquals(List a, List b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      other is Palabra &&
      other.ingles == ingles &&
      other.espanol == espanol &&
      listEquals(other.ejemplos,
          ejemplos) && // Utiliza una función de comparación de listas
      other.definicion == definicion;

  @override
  int get hashCode =>
      ingles.hashCode ^
      espanol.hashCode ^
      ejemplos.hashCode ^
      definicion.hashCode;

  factory Palabra.fromJson(Map<String, dynamic> json) {
    return Palabra(
      json['espanol'] as String,
      json['ingles'] as String,
      json['definicion'] as String,
      (json['ejemplos'] as List<dynamic>).cast<String>(),
      json['categoria'] as String,
    ); // Ensure ejemplos is a List<String>
  }
}

class Usuario {
  String id;
  String usuario;
  List<String> errores;
  int? tiempoTraduccion;
  int? tiempoParejas;
  List<String>? seguidores;
  List<String>? siguiendo;

  Usuario(this.id, this.usuario, this.errores, this.tiempoTraduccion,
      this.tiempoParejas,
      {this.seguidores, this.siguiendo});

  factory Usuario.fromFirestore(
      QueryDocumentSnapshot<Object?> snapshot, SnapshotOptions? options) {
    if (snapshot is QueryDocumentSnapshot<Map<String, dynamic>>) {
      final data = snapshot.data();

      return Usuario(
        snapshot.id,
        data['usuario'],
        data['errores'] is Iterable ? List.from(data['errores']) : [],
        data['tiempoTraduccion'],
        data['tiempoParejas'],
        seguidores:
            data['seguidores'] is Iterable ? List.from(data['seguidores']) : [],
        siguiendo:
            data['siguiendo'] is Iterable ? List.from(data['siguiendo']) : [],
      );
    }
    throw Exception("Se están cargando valores erróneos");
  }

  factory Usuario.fromFirestore2(
      DocumentSnapshot snapshot, SnapshotOptions? options) {
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      final data = snapshot.data();

      return Usuario(
        snapshot.id,
        data!['usuario'],
        data['errores'] is Iterable ? List.from(data['errores']) : [],
        data['tiempoTraduccion'],
        data['tiempoParejas'],
        seguidores:
            data['seguidores'] is Iterable ? List.from(data['seguidores']) : [],
        siguiendo:
            data['siguiendo'] is Iterable ? List.from(data['siguiendo']) : [],
      );
    }
    throw Exception("Se están cargando valores erróneos");
  }

  Map<String, dynamic> toFirestore() {
    return {
      'usuario': usuario,
      'errores': errores,
      'tiempoTraduccion': tiempoTraduccion,
    };
  }

  // Función para comparar listas por contenido
  bool listEquals(List a, List b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  // función para comparar dos usuarios
  @override
  bool operator ==(Object other) =>
      other is Usuario &&
      other.id == id &&
      other.usuario == usuario &&
      listEquals(other.errores,
          errores) && // Utiliza una función de comparación de listas
      other.tiempoTraduccion == tiempoTraduccion;

  @override
  int get hashCode =>
      id.hashCode ^
      usuario.hashCode ^
      errores.hashCode ^
      tiempoTraduccion.hashCode;
}

class Flashcard {
  String id;
  Palabra palabra;
  bool estado;
  int prioridad;

  Flashcard(this.palabra, this.estado, this.prioridad, {this.id = ""});

  factory Flashcard.fromFirestore(
    QueryDocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    if (snapshot is QueryDocumentSnapshot<Map<String, dynamic>>) {
      final data = snapshot.data();

      return Flashcard(
        Palabra.fromJson(data['palabra']),
        data['estado'],
        data['prioridad'],
        id: snapshot.id,
      );
    }
    throw Exception("Se están cargando valores erróneos");
  }

  Map<String, dynamic> toFirestore() {
    return {
      'palabra': palabra.toFirestore(),
      'estado': estado,
      'prioridad': prioridad,
    };
  }
}
