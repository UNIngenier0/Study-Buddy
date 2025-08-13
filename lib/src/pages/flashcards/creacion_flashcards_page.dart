import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/services/firebase_service.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import "package:provider/provider.dart";

class CreacionFlashcardsPage extends StatefulWidget {
  const CreacionFlashcardsPage({Key? key}) : super(key: key);

  @override
  State<CreacionFlashcardsPage> createState() => _CreacionFlashcardsPageState();
}

class _CreacionFlashcardsPageState extends State<CreacionFlashcardsPage> {
  bool showCreateForm = false; // Variable para mostrar el formulario

  void toggleFormVisibility() {
    setState(() {
      showCreateForm = !showCreateForm;
    });
  }

  Future<List<Flashcard>> obtenerFlashcard(
      String userId, BuildContext context) async {
    try {
      FirestoreService firestoreService =
          Provider.of<FirestoreService>(context, listen: false);
      List<Flashcard> fls = await firestoreService.obtenerFlashcard(userId);
      return fls;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "StudyBuddy",
          style: TextStyle(
            fontFamily: "Chewy",
            fontSize: 32,
          ),
        ),
        backgroundColor: azulClaro,
        shadowColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleFormVisibility,
        backgroundColor: azulOscuro,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FutureBuilder<Object>(
        future: obtenerFlashcard(firebaseService.user!.uid, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Flashcard> flashcards = snapshot.data as List<Flashcard>;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: azulOscuro,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.5,
                          horizontal: 11.5,
                        ),
                        child: const Center(
                          child: Text(
                            "Flashcards",
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
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: rojo,
                          size: 37,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            if (showCreateForm)
                              FormularioFlashcard(
                                  onSaved: toggleFormVisibility),
                            if (flashcards.isEmpty)
                              const Text("No hay flashcards creadas")
                            else
                              Column(
                                children: flashcards
                                    .map((flashcard) =>
                                        VistaFlashcard(flashcard))
                                    .toList(),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("Error al obtener las flashcards"),
          );
        },
      ),
    );
  }
}

class FormularioFlashcard extends StatefulWidget {
  const FormularioFlashcard({
    required this.onSaved,
    super.key,
  });

  final void Function() onSaved;

  @override
  State<FormularioFlashcard> createState() => _FormularioFlashcardState();
}

class _FormularioFlashcardState extends State<FormularioFlashcard> {
  final TextStyle estiloTitulo = const TextStyle(
    fontFamily: "Arimo",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: azulOscuro,
  );

  final TextStyle estiloTexto = const TextStyle(
    fontSize: 15,
    fontFamily: "Arimo",
    fontWeight: FontWeight.bold,
  );

  // Datos
  String palabra = "";
  String traduccion = "";
  String? _selectedCategory;
  String? _selectedPriority;
  String definicion = "";
  List<String> ejemplos = [];

  final List<TextEditingController> _exampleControllers = [
    TextEditingController()
  ];

  final _formKey = GlobalKey<FormState>();

  void _agregarCampoEjemplo() {
    if (_exampleControllers.last.text.isNotEmpty) {
      setState(() {
        _exampleControllers.add(TextEditingController());
      });
    }
  }

  void obtenerEjemplos() {
    for (var controller in _exampleControllers) {
      if (controller.text.isNotEmpty) {
        ejemplos.add(controller.text);
      }
    }
  }

  void _eliminarCampoEjemplo(int index) {
    setState(() {
      _exampleControllers.removeAt(index);
    });
  }

  void guardarFlashcard(Flashcard flashcard) async {
    try {
      FirestoreService firestoreService =
          Provider.of<FirestoreService>(context, listen: false);
      FirebaseService firebaseService =
          Provider.of<FirebaseService>(context, listen: false);

      String uid = firebaseService.user!.uid;
      await firestoreService.guardarFlashcard(
        uid,
        flashcard,
      );
      if (context.mounted) {
        widget.onSaved();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    for (var controller in _exampleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: azulRey, width: 3),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Agregar una nueva Flashcard",
              style: TextStyle(
                fontFamily: "Arimo",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una palabra';
                }
                return null;
              },
              onSaved: (newValue) => palabra = newValue!,
              decoration: const InputDecoration(
                labelText: "Palabra",
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una palabra';
                }
                return null;
              },
              onSaved: (newValue) => traduccion = newValue!,
              decoration: const InputDecoration(
                labelText: "Traducción",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: azulRey,
                  ),
                  width: 95,
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      "Categoría",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arimo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DropdownMenu<String>(
                  dropdownMenuEntries: [
                    "Sustantivo",
                    "Adjetivo",
                    "Verbo",
                    "Adverbio",
                    "Preposición",
                    "Otro"
                  ]
                      .map((e) => DropdownMenuEntry<String>(value: e, label: e))
                      .toList(),
                  label: const Text(
                    "Categoría",
                    style: TextStyle(
                      color: gris,
                      fontFamily: "Arimo",
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  onSelected: (String? value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  width: 160,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: azulRey,
                  ),
                  width: 95,
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      "Prioridad",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arimo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DropdownMenu<String>(
                  dropdownMenuEntries: [
                    "Alta",
                    "Media",
                    "Baja",
                  ]
                      .map((e) => DropdownMenuEntry<String>(value: e, label: e))
                      .toList(),
                  label: const Text(
                    "Prioridad",
                    style: TextStyle(
                      color: gris,
                      fontFamily: "Arimo",
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  onSelected: (String? value) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  },
                  width: 160,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Definición",
              style: estiloTitulo,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: azulRey,
                  width: 2,
                ),
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una definición';
                  }
                  return null;
                },
                onSaved: (newValue) => definicion = newValue!,
                style: estiloTexto,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Ejemplos",
              style: estiloTitulo,
            ),
            Column(
              children: List.generate(
                _exampleControllers.length,
                (index) => Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _exampleControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Ejemplo ${index + 1}',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _eliminarCampoEjemplo(index),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _agregarCampoEjemplo,
              style: ElevatedButton.styleFrom(
                backgroundColor: azulRey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Agregar Ejemplo',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Arimo",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  obtenerEjemplos();
                  Flashcard flashcard = Flashcard(
                    Palabra(
                      palabra,
                      traduccion,
                      definicion,
                      ejemplos,
                      _selectedCategory!,
                    ),
                    true,
                    _selectedPriority == "Alta"
                        ? 1
                        : _selectedPriority == "Media"
                            ? 2
                            : 3,
                  );
                  guardarFlashcard(flashcard);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: azulOscuro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Arimo",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VistaFlashcard extends StatelessWidget {
  const VistaFlashcard(this.flashcard, {Key? key}) : super(key: key);
  final Flashcard flashcard;
  final TextStyle estiloTexto = const TextStyle(
    fontSize: 15,
    fontFamily: "Arimo",
    fontWeight: FontWeight.bold,
  );

  final TextStyle estiloTitulo = const TextStyle(
    fontFamily: "Arimo",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: azulOscuro,
  );

  String obtenerPrioridad(int prioridad) {
    if (prioridad == 1) {
      return "Alta";
    } else if (prioridad == 2) {
      return "Media";
    } else {
      return "Baja";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: azulRey, width: 3),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              flashcard.palabra.ingles,
              style: estiloTexto,
            ),
            const Divider(
              thickness: 4,
              color: azulRey,
            ),
            Text(
              flashcard.palabra.espanol,
              style: estiloTexto,
            ),
            const Divider(
              thickness: 4,
              color: azulRey,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: azulRey,
                  ),
                  width: 95,
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      "Categoría",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arimo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: gris, width: 1),
                  ),
                  child: Center(child: Text(flashcard.palabra.categoria)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: azulRey,
                  ),
                  width: 95,
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      "Prioridad",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Arimo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: gris, width: 1),
                  ),
                  child: Center(
                      child: Text(obtenerPrioridad(flashcard.prioridad))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Definición",
              style: estiloTitulo,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: azulRey,
                  width: 2,
                ),
              ),
              child: Text(
                flashcard.palabra.definicion,
                style: estiloTexto,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Ejemplos",
              style: estiloTitulo,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.arrow_right),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      title: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: azulRey,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Text(
                          flashcard.palabra.ejemplos[index],
                          style: estiloTexto,
                        ),
                      ),
                    );
                  },
                  itemCount: flashcard.palabra.ejemplos.length),
            ),
          ],
        ),
      ),
    );
  }
}
