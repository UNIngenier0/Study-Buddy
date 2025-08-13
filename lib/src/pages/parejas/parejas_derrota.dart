import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';

class ParejasDerrota extends StatefulWidget {
  //?Esta pagina podria ser StatelessWidget
  const ParejasDerrota({Key? key, 
  })
      :super(key: key);

  @override
  State<ParejasDerrota> createState() => _ParejasDerrota();
}

class _ParejasDerrota extends State<ParejasDerrota> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!Titulo de la pagina
      appBar: AppBar(
          title: const Text("StudyBuddy",
          style: TextStyle(fontFamily: "Chewy", fontSize: 32)),
          automaticallyImplyLeading: false,
          backgroundColor: azulClaro),

      //!Cuerpo de la pagina
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        //!Titulo de la dinamica y boton de salida
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),

          //!Cuerpo de la pagina, titulo imagen, parrafo y boton de inicio
          //Texto de pagina
          const Text("¡Casi lo logras!",
              style: TextStyle(fontFamily: "Chewy", fontSize: 48)),

          Image.asset("assets/images/quokka-x.png", width: 186),

          const SizedBox(
            width: 185,
          ),

          //Boton de inicio
          SizedBox(
            width: 200,
            height: 57,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: azulRey,
              ),
              child: const Text(
                "jugar de nuevo",
                style: TextStyle(
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),

          SizedBox(
            width: 200,
            height: 57,
            child: ElevatedButton(
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName("/")), //Volver al inicio
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: azulRey,
              ),
              child: const Text(
                "Regresa al menu",
                style: TextStyle(
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          const BarraInferior(),
        ],
      ),
    );
  }
}
