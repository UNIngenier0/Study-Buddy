import 'dart:async';

import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/pages/traduccion/final_traduccion_page.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import 'package:study_buddy/src/services/firebase_service.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/widgets/flashcard.dart' as Flashcard;

import '../../data_structures/queue.dart' as queue;

class TraduccionEjercicioPage extends StatefulWidget {
  const TraduccionEjercicioPage({Key? key}) : super(key: key);

  @override
  _TraduccionEjercicioPageState createState() =>
      _TraduccionEjercicioPageState();
}

class _TraduccionEjercicioPageState extends State<TraduccionEjercicioPage> {
  String imagenAsset = "assets/images/quokka-pregunta.png";
  Palabra? palabra;

  bool answeredForm = false;

  late _FormularioState formulario;
  late _TemporizadorState temporizador;

  queue.Queue words = queue.Queue(11);

  void cargarPalabras() async {
    final FirestoreService firestoreService = FirestoreService();
    final List<Palabra> palabras = await firestoreService.getPalabras();
    palabras.shuffle();
    // Los ejercicios tendrán 10 palabras
    for (int i = 0; i < 10; i++) {
      words.enqueue(palabras[i]);
    }

    setState(() {
      palabra = words.dequeue();
    });
  }

  @override
  void initState() {
    super.initState();
    cargarPalabras();
  }

  // Procesar la respuesta del formulario respondido

  void procesarRespuesta(bool correcto, FirebaseService firebaseService,
      FirestoreService firestoreService) {
    if (correcto) {
      // Mostrar imagen de copa
      cambiarImagen("assets/images/quokka-copa.png");
    } else {
      // Mostrar imagen de X
      cambiarImagen("assets/images/quokka-x2.png");
    }
    if (!correcto) {
      words.enqueue(palabra!);
      guardarError(firebaseService, firestoreService);
    }
  }

  // Cambiar la imagen del quokka

  void cambiarImagen(String nuevaRuta) {
    setState(() {
      imagenAsset = nuevaRuta;
    });
  }

  // Guardar el error en la base de datos

  void guardarError(FirebaseService firebaseService,
      FirestoreService firestoreService) async {
    await firestoreService.agregarError(firebaseService.user!.uid, palabra!.id);
  }

  // Procesar para seguir a la siguiente palabra
  void procesaraSiguiente(BuildContext context) {
    if (words.isEmpty()) {
      // Obtener el tiempo del temporizador
      int tiempo = temporizador._stopTimer();

      // Si ya no hay palabras, ir a la página final
      // Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FinalTraduccion(tiempo)));
    } else {
      setState(() {
        palabra = words.dequeue();
        answeredForm = false;
        imagenAsset = "assets/images/quokka-pregunta.png";
      });

      // Restablecer estilos del formulario
      formulario.reiniciarEstilos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    final FirebaseService firebaseService = FirebaseService();
    if (palabra == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "StudyBuddy",
          style: TextStyle(
            fontFamily: "Chewy",
            fontSize: 32,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: azulClaro,
        shadowColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 36,
                        width: 93,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: azulOscuro,
                        ),
                        child: const Center(
                          child: Text(
                            "Traducir",
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
                      Temporizador(onTemporizadorCreated: (temp) {
                        temporizador = temp;
                      }),
                      IconButton(
                        onPressed: () => Navigator.pop(
                            context), // Volver a la página anterior
                        icon: const Icon(
                          Icons.cancel,
                          color: rojo,
                          size: 37,
                        ),
                      ),
                    ],
                  ),
                  Flashcard.Flashcard(
                    pregunta: palabra!.ingles,
                    respuesta: palabra!.definicion,
                  ),
                  const SizedBox(
                    width: 350,
                    child: Text(
                      "Completa:",
                      style: TextStyle(
                        fontFamily: "Arimo",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: gris,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Formulario(
                    palabra!.espanol,
                    cambiarImagen,
                    onFormAnswered: (correcto) {
                      setState(() {
                        answeredForm = true;
                      });
                      procesarRespuesta(
                          correcto, firebaseService, firestoreService);
                    },
                    onFormCreated: (form) {
                      formulario = form;
                    },
                  ),
                  Image.asset(
                    imagenAsset,
                    width: 159,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/traduccion/errores"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: amarillo,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Ver Errores",
                          style: TextStyle(
                            color: azulOscuro,
                            fontFamily: "Arimo",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (answeredForm)
                        ElevatedButton(
                          onPressed: () {
                            procesaraSiguiente(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: azulClaro,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Siguiente",
                            style: TextStyle(
                              color: azulOscuro,
                              fontFamily: "Arimo",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const BarraInferior(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario(this.traduccion, this.cambiarImagen,
      {super.key, required this.onFormAnswered, required this.onFormCreated});
  final String traduccion;
  final Function(String) cambiarImagen;
  final void Function(bool) onFormAnswered;
  final void Function(_FormularioState state)? onFormCreated;

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controladorTexto = TextEditingController();

  bool editar = true;

  Color colorCampoTexto = Colors.white;

  Color colorTexto = Colors.black;

  String palabraUsuario = "";

  @override
  void initState() {
    super.initState();
    widget.onFormCreated?.call(this);
  }

  void reiniciarEstilos() {
    setState(() {
      colorCampoTexto = Colors.white;
      colorTexto = Colors.black;
      editar = true;
    });

    controladorTexto.clear();
  }

  void actualizarColorCampoTexto(bool correcto) {
    setState(() {
      if (correcto) {
        colorCampoTexto = verde;
      } else {
        colorCampoTexto = rojo;
      }
    });
  }

  void actualizarColorTexto() {
    setState(() {
      colorTexto = Colors.white;
    });
  }

  @override
  void dispose() {
    controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 255,
            child: TextFormField(
              controller: controladorTexto,
              style: TextStyle(
                color: colorTexto,
                fontFamily: "Arimo",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              onSaved: (newValue) => palabraUsuario = newValue!,
              decoration: InputDecoration(
                hintText: 'Escribe la traducción en español',
                fillColor: colorCampoTexto,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: azulOscuro,
                    width: 4,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Escribe la traducción en español';
                }
                return null;
              },
              enabled: editar,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 59,
            height: 59,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: azulOscuro,
            ),
            child: IconButton(
              onPressed: editar
                  ? () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        bool correcto =
                            widget.traduccion.toLowerCase().trim() ==
                                palabraUsuario.toLowerCase().trim();

                        if (correcto) {
                          widget.cambiarImagen("assets/images/quokka-copa.png");
                        } else {
                          widget.cambiarImagen("assets/images/quokka-x2.png");
                        }

                        actualizarColorCampoTexto(correcto);
                        actualizarColorTexto();

                        setState(
                          () {
                            editar = false;
                          },
                        );

                        widget.onFormAnswered(correcto);
                      }
                    }
                  : null,
              icon: const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Temporizador extends StatefulWidget {
  const Temporizador({super.key, required this.onTemporizadorCreated});
  final void Function(_TemporizadorState state)? onTemporizadorCreated;

  @override
  State<Temporizador> createState() => _TemporizadorState();
}

class _TemporizadorState extends State<Temporizador> {
  int segundos = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    widget.onTemporizadorCreated?.call(this);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        segundos++;
      });
    });
  }

  int _stopTimer() {
    _timer.cancel();
    return segundos;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.timer,
          color: azulRey,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: azulRey,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "${segundos ~/ 60}:${(segundos % 60).toString().padLeft(2, '0')}",
            style: const TextStyle(
              fontFamily: "Arimo",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
