import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/widgets/barra_inferior.dart';

class ParejasPage extends StatefulWidget { //?Esta pagina podria ser StatelessWidget
  
  const ParejasPage({super.key});

  @override
  State <ParejasPage> createState() => _ParejasPage();
}

class _ParejasPage extends State<ParejasPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!Titulo de la pagina 
      appBar: AppBar(
        title: const Text("StudyBuddy", style: TextStyle( fontFamily: "Chewy", fontSize: 32)),
        automaticallyImplyLeading: false,
        backgroundColor: azulClaro
      ),

      //!Cuerpo de la pagina
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        //!Titulo de la dinamica y boton de salida 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            
            children: [
              Container( height: 35, width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: azulOscuro),
                child: const Center(
                  child: Text( "Parejas", textAlign: TextAlign.center, style: TextStyle( fontFamily: "Arimo", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon( Icons.cancel, color: rojo, size: 37 ),
              )
            ],
          ),

        //!Cuerpo de la pagina, titulo imagen, parrafo y boton de inicio
          //Texto de pagina
          const Text( "¿Preparado?", style: TextStyle(fontFamily: "Chewy", fontSize: 48)),

          Image.asset( "assets/images/quokka-papeles.png", width: 186),

          const SizedBox(
            width: 185,
            child: Text(
              "!Selecciona los terminos con sus definiciones!",
              style: TextStyle(
                fontFamily: "Aribo",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: gris,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          //Boton de inicio
          SizedBox(
            width: 147,
            height: 57,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/parejas/game"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: azulRey,
              ),
              child: const Text(
                "Iniciar",
                style: TextStyle(
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ),
          ),
          const BarraInferior(),
        ],
      ),
    );
  }
}
