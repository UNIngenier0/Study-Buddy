import 'package:flutter/material.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/src/data_structures/map.dart';
import 'package:study_buddy/src/data_structures/set.dart';
// import 'package:flutter_svg/svg.dart';

class PalabrasListaPage extends StatefulWidget {
  const PalabrasListaPage({super.key});

  @override
  State<PalabrasListaPage> createState() => _PalabrasListaPageState();
}

class _PalabrasListaPageState extends State<PalabrasListaPage> {
  String botonPresionado = "Sustantivo";
  MiMap<String, MiSet<Palabra>>? palabrasCategorizadas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPalabras();
  }

  void cambiarBotonPresionado(String boton) {
    setState(() {
      botonPresionado = boton;
    });
  }

  void getPalabras() async {
    FirestoreService firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    List<Palabra> palabras = await firestoreService.getPalabras();
    var cat = MiMap<String, MiSet<Palabra>>(10);
    for (Palabra palabra in palabras) {
      if (cat.hasKey(palabra.categoria)) {
        cat.get(palabra.categoria)!.insert(palabra);
      } else {
        MiSet<Palabra> set = MiSet<Palabra>(10);
        set.insert(palabra);
        cat.set(palabra.categoria, set);
      }
    }

    setState(() {
      palabrasCategorizadas = cat;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: azulOscuro,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "Palabras",
                  style: TextStyle(
                    fontFamily: "Arimo",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Sustantivo"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor: botonPresionado == "Sustantivo"
                            ? azulRey
                            : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Sustantivos",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Sustantivo"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Adjetivo"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor:
                            botonPresionado == "Adjetivo" ? azulRey : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Adjetivos",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Adjetivo"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Verbo"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor:
                            botonPresionado == "Verbo" ? azulRey : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Verbos",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Verbo"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Adverbio"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor:
                            botonPresionado == "Adverbio" ? azulRey : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Adverbios",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Adverbio"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Preposicion"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor: botonPresionado == "Preposicion"
                            ? azulRey
                            : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Preposiciones",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Preposicion"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("Otro"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor:
                            botonPresionado == "Otro" ? azulRey : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Otros",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "Otro"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: palabrasCategorizadas != null
                    ? (palabrasCategorizadas!.get(botonPresionado)?.empty ??
                            true)
                        ? const Center(
                            child: Text(
                              'No hay palabras en esta categoría.',
                              style: TextStyle(
                                fontFamily: "Arimo",
                                fontSize: 16,
                                color: azulOscuro,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return PalabraCard(
                                palabra: palabrasCategorizadas!
                                    .get(botonPresionado)!
                                    .toList()[index],
                              );
                            },
                            itemCount: palabrasCategorizadas!
                                .get(botonPresionado)!
                                .size,
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              const BarraInferior(),
            ],
          ),
        ),
      ),
    );
  }
}

class PalabraCard extends StatefulWidget {
  const PalabraCard({Key? key, required this.palabra}) : super(key: key);
  final Palabra palabra;

  @override
  State<PalabraCard> createState() => _PalabraCardState();
}

class _PalabraCardState extends State<PalabraCard> {
  // bool favorito = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(
            context,
            "/traduccion/palabra",
            arguments: {"palabra": widget.palabra},
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: gris,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
          ),
          // child:
          // // Row(
          // //   children: [
          //     Expanded(
          //       child: Center(
          child: Text(
            widget.palabra.ingles,
            style: const TextStyle(
              fontFamily: "Arimo",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: azulRey,
            ),
          ),
          //     ),
          //   ),
          //   InkWell(
          //     onTap: () => setState(() {
          //       favorito = !favorito;
          //     }),
          //     child: SvgPicture.asset(
          //       "assets/images/star-bold.svg",
          //       colorFilter: ColorFilter.mode(
          //         favorito ? amarillo : grisClaro,
          //         BlendMode.srcIn,
          //       ),
          //     ),
          //   ),
          // ],
          // ),
        ),
      ),
    );
  }
}
