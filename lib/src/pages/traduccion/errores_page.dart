import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/services/firebase_service.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import "package:provider/provider.dart";

class ErroresPage extends StatefulWidget {
  const ErroresPage({Key? key}) : super(key: key);

  @override
  _ErroresPageState createState() => _ErroresPageState();
}

class _ErroresPageState extends State<ErroresPage> {
  List<Palabra>? errores;

  @override
  void initState() {
    super.initState();
  }

  void obtenerErrores(String userId, BuildContext context) async {
    try {
      FirestoreService firestoreService =
          Provider.of<FirestoreService>(context, listen: false);
      var erroress = await firestoreService.obtenerErrores(userId);
      if (mounted) {
        // Verificar si el widget está montado
        setState(() {
          errores = erroress;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);

    obtenerErrores(firebaseService.user!.uid, context);

    if (errores == null) {
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
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  IconButton(
                    onPressed: () => Navigator.popUntil(
                        context, ModalRoute.withName("/")), //Volver al inicio
                    icon: const Icon(
                      Icons.cancel,
                      color: rojo,
                      size: 37,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 270,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: amarillo,
              ),
              child: const Center(
                child: Text(
                  "Errores hasta el momento",
                  style: TextStyle(
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    ErrorCard(palabra: errores![index]),
                itemCount: errores!.length,
              ),
            ),
            const BarraInferior(),
          ],
        ),
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key, required this.palabra}) : super(key: key);
  final Palabra palabra;

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
            arguments: {"palabra": palabra},
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: gris,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            palabra.ingles,
            style: const TextStyle(
              fontFamily: "Arimo",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: azulRey,
            ),
          ),
        ),
      ),
    );
  }
}
