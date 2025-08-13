import 'dart:core';

bool compararFrases(String frase1, String frase2) {
  /// Compara dos frases y devuelve true si son iguales y false si no lo son.

  // Convertir las frases a minúsculas
  frase1 = frase1.toLowerCase();
  frase2 = frase2.toLowerCase();

  // Eliminar los espacios al inicio y final
  frase1 = frase1.trim();
  frase2 = frase2.trim();

  // Eliminar los signos de puntuación
  RegExp regexPuntuacion = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  frase1 = frase1.replaceAll(regexPuntuacion, '');
  frase2 = frase2.replaceAll(regexPuntuacion, '');

  // Eliminar los espacios de más
  RegExp regexEspacios = RegExp(r'\s+');
  frase1 = frase1.replaceAll(regexEspacios, ' ');
  frase2 = frase2.replaceAll(regexEspacios, ' ');

  // Comparar las frases
  return frase1 == frase2;
}
