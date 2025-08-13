import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/src/app.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/widgets/creador_palabras.dart';
import 'dart:math';

class ParejasGame extends StatefulWidget {
  const ParejasGame({Key? key}) : super(key: key);
  @override
  State<ParejasGame> createState() => _ParejasGame();
}

class _ParejasGame extends State<ParejasGame> {
  //!Variables
  //!Diccionario que almacena las palabras para cada columna
  Map<String, String> parejas = {};
  String selectedWordA = ''; // Palabra seleccionada en la columna A
  String selectedWordB = ''; // Palabra seleccionada en la columna B
  List<String> palabrasColumnaIzquierda = [];

  double timeRemaining = 1.0;

  int aciertos = 0;
  int desaciertos = 0;
  Timer? timer; 
  DateTime? startTime; // Variable para almacenar la hora de inicio del juego


  @override
  void initState() {
    getPalabras();
    super.initState();
    startTime = DateTime.now(); // Registra la hora de inicio del juego
    //!Iniciar el temporizador en initState
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        timeRemaining -= 0.0001;
        if (timeRemaining <= 0) {
          timer.cancel();
          mostrarMensaje();
        }
      });
    });
  }
  List<String> shuffleWords(List<String> words) {
    List<String> shuffledWords = [];

    for (int i = 0; i < words.length; i += 5) {
      List<String> group = words.sublist(i, min(i + 5, words.length));
      group.shuffle();
      shuffledWords.addAll(group);
    }

    return shuffledWords;
  }

  //!Firebase
  Future<void> getPalabras() async {
    try {
      final CollectionReference collectionReference = FirebaseFirestore.instance.collection("palabras");
      final QuerySnapshot palabras = await collectionReference.get();
    
      final Map<String, String> tempParejas = {};

      for (final QueryDocumentSnapshot palabra in palabras.docs) {
        final String espanol = palabra["espanol"];
        final String ingles = palabra["ingles"];

        tempParejas[espanol] = ingles;
      }

      setState(() {
        parejas = tempParejas;

        //!Copia las palabras de la columna izquierda y las baraja aleatoriamente
        //palabrasColumnaIzquierda = parejas.keys.toList()..shuffle();
        palabrasColumnaIzquierda = shuffleWords(parejas.keys.toList());

      });
    } catch (e) {
      print("Error al cargar palabras desde Firestore: $e");
    }
  }

void mostrarMensaje() {
  final endTime = DateTime.now();
  final tiempoTranscurrido = endTime.millisecondsSinceEpoch - startTime!.millisecondsSinceEpoch; // Calcula la diferencia de tiempo en milisegundos

  final tiempoCompletado = tiempoTranscurrido / 1000.0; // Convierte el tiempo a segundos

  timeRemaining = 1.0; // Reiniciar el temporizador
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("¡Juego completado!"),
        content: Text("Aciertos: $aciertos\nDesaciertos: $desaciertos\nTiempo transcurrido: ${tiempoCompletado.toStringAsFixed(2)} segundos"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyApp())); // Navegar al menú principal
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

  //!Comprueba si hay una coincidencia
  void handleMatching() {
    if (selectedWordA.isNotEmpty && selectedWordB.isNotEmpty) {
      if (parejas.containsKey(selectedWordA) && parejas[selectedWordA] == selectedWordB) {
        // Coincidencia encontrada, elimina las palabras del diccionario
        parejas.remove(selectedWordA);
        parejas.remove(selectedWordB);
        palabrasColumnaIzquierda.remove(selectedWordA);
        setState(() {
          aciertos++; // Incrementar el contador de aciertos
        });
        // Limpiar las selecciones
        selectedWordA = '';
        selectedWordB = '';
        
        // Comprobar si ya no quedan más parejas
        if (parejas.isEmpty) {
          // Muestra un mensaje al usuario y detén el temporizador
          mostrarMensaje();
          timer?.cancel();
        }
      } else {
        // No coincidencia, incrementar el contador de desaciertos
        desaciertos++;
        // Limpiar las selecciones
        selectedWordA = '';
        selectedWordB = '';
      }
    }
  }


  @override
  void dispose() {
    // Cancelar el temporizador en el método dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!Barra superior
      appBar: AppBar(
        title: const Text(
          "StudyBuddy",
          style: TextStyle(
            fontFamily: "Chewy",
            fontSize: 32,
          ),
        ),
        automaticallyImplyLeading: false, // Eliminar el ícono de "atrás"
        backgroundColor: azulClaro,
      ),

      //!Cuerpo
      body: Column(
        children: [
          //!Barra superior con opcion de salida
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: azulOscuro,
                ),
                child: const Center(
                  child: Text(
                    "Parejas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Arimo",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 105),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel, color: rojo, size: 37),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //!Barra de progreso
          Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Ajusta el valor para el redondeo deseado
              border: Border.all(color: azulClaro), // Agrega un borde si lo deseas
            ),
            child: LinearProgressIndicator(
              value: timeRemaining,
              backgroundColor: Colors.grey,
              minHeight: 10,
              valueColor: AlwaysStoppedAnimation<Color>(
                timeRemaining < 0.5 ? Colors.red : azulClaro,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //!Cuerpo del juego
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alinea las columnas en horizontal
              children: [
                Expanded(
                  child: ListView.builder(
                    //itemCount: palabrasColumnaIzquierda.length,
                    itemCount: palabrasColumnaIzquierda.length < 5 ? palabrasColumnaIzquierda.length : 5, // Limita a 5 elementos o menos
                    itemBuilder: (context, index) {
                      final key = palabrasColumnaIzquierda[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: CreaPalabras(
                          palabra: key,
                          isSelected: key == selectedWordA,
                          onTap: () {
                            setState(() {
                              selectedWordA = key;
                              handleMatching(); // Comprueba si hay una coincidencia
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 35),
                Expanded(
                  child: ListView.builder(
                    //itemCount: parejas.length,
                    itemCount: parejas.length < 5 ?parejas.length : 5, // Limita a 5 elementos o menos
                    itemBuilder: (context, index) {
                      final key = parejas.keys.elementAt(index);
                      final value = parejas[key]!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: CreaPalabras(
                          palabra: value,
                          isSelected: value == selectedWordB,
                          onTap: () {
                            setState(() {
                              selectedWordB = value;
                              handleMatching(); // Comprueba si hay una coincidencia
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const BarraInferior(),
        ],
      ),
    );
  }
}
