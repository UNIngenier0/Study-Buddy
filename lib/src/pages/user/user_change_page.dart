import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import "package:study_buddy/src/services/firebase_service.dart";
import "package:study_buddy/src/services/firestore_service.dart";
import "package:provider/provider.dart";

class UserChangePage extends StatelessWidget {
  const UserChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 220,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: azulRey,
                ),
                child: const Center(
                  child: Text(
                    "Nuevo nombre de usuario",
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
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nuevo Usuario",
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Arimo",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: gris,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/quokka-pregunta.png",
              width: 150,
            ),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus(); // Desenfoca el campo de texto
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Impide cerrar la pantalla de carga con un tap afuera
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(), // Pantalla de carga
                    );
                  },
                );
                try {
                  await firestoreService.updateUser(
                      firebaseService.user!.uid, _controller.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Usuario modficado exitosamente"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  Navigator.pop(context);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error al modificar el usuario"),
                      ),
                    );
                  }
                  ;
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(235, 30),
                elevation: 0,
                backgroundColor: verde,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.5, vertical: 4),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                "Aceptar",
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
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(235, 30),
                elevation: 0,
                backgroundColor: rojo,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.5, vertical: 4),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                "Cancelar",
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
      ),
    );
  }
}
