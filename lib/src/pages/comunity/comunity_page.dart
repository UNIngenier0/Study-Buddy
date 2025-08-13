import 'package:flutter/material.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import "package:study_buddy/src/services/firebase_service.dart";
import 'package:provider/provider.dart';

class ComunityPage extends StatefulWidget {
  const ComunityPage({super.key});

  @override
  State<ComunityPage> createState() => _ComunityPageState();
}

class _ComunityPageState extends State<ComunityPage> {
  String botonPresionado = "usuariosBase";

  void cambiarBotonPresionado(String boton) {
    setState(() {
      botonPresionado = boton;
    });
  }

  Future<List<Usuario>> obtenerUsuarios() async {
    FirestoreService firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    FirebaseService firebaseService =
        Provider.of<FirebaseService>(context, listen: false);

    List<Usuario> usuarios = [];

    if (botonPresionado == "usuariosBase") {
      usuarios = await firestoreService.obtenerUsuarios();
    } else if (botonPresionado == "usuariosConocer") {
      usuarios = await firestoreService
          .obtenerSeguidosDeSeguidos(firebaseService.user!.uid);
    } else {
      usuarios = await firestoreService.obtenerUsuarios();
    }

    return usuarios
        .where((element) => element.id != firebaseService.user!.uid)
        .toList();
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
                  "Comunidad",
                  style: TextStyle(
                    fontFamily: "Arimo",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => cambiarBotonPresionado("usuariosBase"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: botonPresionado == "usuariosBase"
                            ? azulRey
                            : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Usuarios",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "usuariosBase"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () =>
                          cambiarBotonPresionado("usuariosConocer"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: botonPresionado == "usuariosConocer"
                            ? azulRey
                            : azulClaro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Usuarios que quizás conozcas",
                        style: TextStyle(
                          fontFamily: "Arimo",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: botonPresionado == "usuariosConocer"
                              ? Colors.white
                              : azulRey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      List<Usuario> usuarios = snapshot.data as List<Usuario>;
                      return Expanded(
                        child: usuarios.isEmpty
                            ? const Text(
                                "No hay usuarios registrados",
                                style: TextStyle(
                                  fontFamily: "Arimo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      leading: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.fromBorderSide(
                                            BorderSide(
                                              color: azulRey,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "${index + 1}",
                                            style: const TextStyle(
                                              fontFamily: "Arimo",
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: azulRey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        usuarios[index].usuario,
                                        style: const TextStyle(
                                          fontFamily: "Arimo",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      trailing: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/comunidad/usuario",
                                            arguments: {
                                              "usuario": usuarios[index]
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          backgroundColor: amarillo,
                                        ),
                                        child: const Text(
                                          "Ver Perfil",
                                          style: TextStyle(
                                            color: azulOscuro,
                                            fontSize: 15,
                                            fontFamily: "Arimo",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: usuarios.length,
                              ),
                      );
                    }
                  }),
              const BarraInferior(),
            ],
          ),
        ),
      ),
    );
  }
}
