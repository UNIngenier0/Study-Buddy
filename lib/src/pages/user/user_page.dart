import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/pages/user/user_change_page.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import "package:study_buddy/src/services/firebase_service.dart";
import "package:study_buddy/src/services/firestore_service.dart";
import "package:study_buddy/src/services/barra_inferior_service.dart";
import "package:provider/provider.dart";

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  Future<String> _getUserData(FirebaseService firebaseService,
      FirestoreService firestoreService) async {
    try {
      String usuario;
      if (firebaseService.user != null) {
        String id = firebaseService.user!.uid;
        usuario = await firestoreService.getUser(id);
      } else {
        usuario = "Usuario";
      }
      return usuario;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);
    BottomBarProvider bottomBarProvider =
        Provider.of<BottomBarProvider>(context);
    return FutureBuilder<Object>(
        future: _getUserData(firebaseService, firestoreService),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error al obtener los datos del usuario"),
              ),
            );
          }
          String username = snapshot.data as String;
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            "Perfil",
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
                    ],
                  ),
                ),
                Container(
                  width: 93,
                  padding: const EdgeInsets.all(7),
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
                Container(
                  width: 140,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(
                      color: gris,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      username,
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
                Image.asset(
                  "assets/images/quokka-copa.png",
                  width: 150,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserChangePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(235, 30),
                    elevation: 0,
                    backgroundColor: amarillo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.5, vertical: 4),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child: const Text(
                    "Cambiar el nombre de usuario",
                    style: TextStyle(
                      fontFamily: "Arimo",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: azulOscuro,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      print("hoaol");

                      firebaseService.signOut();
                      bottomBarProvider.setActiveIcon("home");
                      Navigator.popUntil(
                          context, (route) => route.settings.name == "/");
                    } catch (e) {
                      print(e.toString());
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            duration: const Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(235, 30),
                    elevation: 0,
                    backgroundColor: rojo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.5, vertical: 4),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child: const Text(
                    "Cerrar Sesión",
                    style: TextStyle(
                      fontFamily: "Arimo",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const BarraInferior(),
              ],
            ),
          );
        });
  }
}
