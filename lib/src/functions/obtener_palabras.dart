import 'dart:convert';
import 'dart:io';

class Palabra {
  String ingles;
  String espanol;
  List<String> ejemplos;
  String definicion;

  Palabra(this.espanol, this.ingles, this.definicion, this.ejemplos);

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
    ); // Ensure ejemplos is a List<String>
  }
}

Future<List<dynamic>> getDataFromJson(String filePath) async {
  final file = File(filePath);
  final contents = await file.readAsString();
  final jsonData = json.decode(contents);
  return jsonData;
}

void main() {
  getDataFromJson('assets/json/10000_datos.json').then((data) {
    print(data[0].runtimeType);
  });
}
