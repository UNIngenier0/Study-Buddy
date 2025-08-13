import 'package:flutter/material.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/services/firebase_service.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import "package:provider/provider.dart";

class FinalTraduccion extends StatelessWidget {
  const FinalTraduccion(this.tiempo, {super.key});
  final int tiempo;

  Future<void> guardarTiempo(FirestoreService firestoreService,
      FirebaseService firebaseService) async {
    String uid = firebaseService.user!.uid;
    await firestoreService.guardarTiempo(uid, tiempo);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);

    guardarTiempo(firestoreService, firebaseService);

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
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "¡Felicidades!",
                style: TextStyle(
                  fontFamily: "Chewy",
                  fontSize: 48,
                ),
              ),
              Image.asset(
                "assets/images/quokka-copa.png",
                width: 196,
              ),
              SizedBox(
                width: 196,
                child: Text(
                  "Lo has logrado en ${tiempo ~/ 60}:${(tiempo % 60).toString().padLeft(2, '0')} segundos ¡Muy Bien!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: gris,
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: azulRey,
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Jugar de nuevo",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: azulRey,
                      width: 3,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName("/")),
                child: const Text(
                  "Regresar",
                  style: TextStyle(
                    color: azulOscuro,
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
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
