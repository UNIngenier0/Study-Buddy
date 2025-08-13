import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import "package:study_buddy/src/services/firebase_service.dart";
import 'package:flutter_svg/svg.dart';
import "package:provider/provider.dart";

class UsuarioExternoPage extends StatefulWidget {
  const UsuarioExternoPage({Key? key}) : super(key: key);

  @override
  _UsuarioExternoPageState createState() => _UsuarioExternoPageState();
}

class _UsuarioExternoPageState extends State<UsuarioExternoPage> {
  void seguirUsuario(Usuario usuario) async {
    FirebaseService firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    FirestoreService firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    // Obten el ID del usuario actual
    String miId = firebaseService.user!.uid;

    if (usuario.seguidores?.contains(miId) ?? true) {
      return;
    }
    usuario.seguidores?.add(miId);

    // Actualiza la base de datos para agregar el usuario seguido
    await firestoreService.seguirUsuario(miId, usuario.id);
  }

  void dejarDeSeguirUsuario(Usuario usuario) async {
    FirebaseService firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    FirestoreService firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    // Obten el ID del usuario actual
    String miId = firebaseService.user!.uid;

    usuario.seguidores?.remove(miId);

    // Actualiza la base de datos para agregar el usuario seguido
    await firestoreService.dejarSeguirUsuario(miId, usuario.id);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    Usuario usuario = argumentos["usuario"];
    int? tiempoParejas = usuario.tiempoParejas;
    int? tiempoTraduccion = usuario.tiempoTraduccion;

    String stringParejas = tiempoParejas == null
        ? "No hay tiempo registrado"
        : "Tiempo: ${(tiempoParejas ~/ 60).toString().padLeft(2)}:${(tiempoParejas % 60).toString().padLeft(2)}";
    String stringTraduccion = tiempoTraduccion == null
        ? "No hay tiempo registrado"
        : "Tiempo: ${(tiempoTraduccion ~/ 60).toString().padLeft(2)}:${(tiempoTraduccion % 60).toString().padLeft(2)}";

    bool esSeguido =
        usuario.seguidores?.contains(firebaseService.user!.uid) ?? false;

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
      body: SingleChildScrollView(
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
                Transform.rotate(
                  angle: -90 * 3.141592 / 180,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(
                      "assets/images/up-arrow.svg",
                      colorFilter: const ColorFilter.mode(
                        verde,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 93,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: azulRey,
                      ),
                      child: const Center(
                        child: Text(
                          "Usuario",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Arimo",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: gris,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Text(
                            usuario.usuario,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Arimo",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: gris,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: gris,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Text(
                            "Seguidores: ${usuario.seguidores?.length ?? 0}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Arimo",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: gris,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/quokka-copa.png",
                  width: 150,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (esSeguido) {
                  dejarDeSeguirUsuario(usuario);
                } else {
                  seguirUsuario(usuario);
                }
                // Vuelve a verificar el estado después de seguir o dejar de seguir
                bool sigueUsuarioActualizado =
                    usuario.seguidores?.contains(firebaseService.user!.uid) ??
                        false;

                setState(() {
                  esSeguido = sigueUsuarioActualizado;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: esSeguido ? amarillo : azulOscuro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                esSeguido ? "Dejar de seguir" : "Seguir",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: esSeguido ? azulOscuro : Colors.white,
                  fontFamily: "Arimo",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: azulOscuro,
                    width: 3,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images/squares-2x2-solid.svg",
                      width: 65,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Parejas",
                            style: TextStyle(
                              fontFamily: "Chewy",
                              fontSize: 24,
                              color: azulOscuro,
                            ),
                          ),
                          Text(
                            stringParejas,
                            style: const TextStyle(
                              color: gris,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Arimo",
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: azulOscuro,
                    width: 3,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/traducir.png",
                      width: 65,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Traducción",
                            style: TextStyle(
                              fontFamily: "Chewy",
                              fontSize: 24,
                              color: azulOscuro,
                            ),
                          ),
                          Text(
                            stringTraduccion,
                            style: const TextStyle(
                              color: gris,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Arimo",
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const BarraInferior(),
          ],
        ),
      ),
    );
  }
}
