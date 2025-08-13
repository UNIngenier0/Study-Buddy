import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_buddy/src/services/firestore_service.dart';

class PalabraPage extends StatefulWidget {
  const PalabraPage({Key? key}) : super(key: key);

  @override
  _PalabraPageState createState() => _PalabraPageState();
}

class _PalabraPageState extends State<PalabraPage> {
  _PalabraPageState();

  @override
  Widget build(BuildContext context) {
    Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    Palabra palabra = argumentos["palabra"];
    // Palabra palabra =
    //     Palabra("Hola", "Hello", "Saludo casual", ["Hello!", "Hi!", "Hey!"]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "StudyBuddy",
          style: TextStyle(
            fontFamily: "Chewy",
            fontSize: 32,
          ),
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: azulClaro,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
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
                      iconSize: 37,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.popUntil(context, ModalRoute.withName("/")),
                    icon: const Icon(
                      Icons.cancel,
                      color: rojo,
                      size: 37,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
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
              ),
              Text(
                "${palabra.ingles} - ${palabra.espanol}",
                style: const TextStyle(
                  fontFamily: "Chewy",
                  fontSize: 48,
                  color: azulOscuro,
                ),
              ),
              const Divider(
                thickness: 4,
                color: azulRey,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  palabra.definicion,
                  style: const TextStyle(
                    fontFamily: "Arimo",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ejemplos:",
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arimo",
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: palabra.ejemplos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        // Creating a circle avatar as a bullet point
                        backgroundColor: Colors
                            .black, // Customize the color of the bullet point
                        radius: 4, // Adjust the size of the bullet point
                      ),
                      title: Text(
                        palabra.ejemplos[index],
                        style: const TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arimo",
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
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
