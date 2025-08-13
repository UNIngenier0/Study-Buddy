import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:study_buddy/src/constants/colors.dart';

class Flashcard extends StatefulWidget {
  const Flashcard(
      {Key? key,
      this.pregunta = "Pregunta",
      this.respuesta = "Respuesta",
      this.width = 219,
      this.height = 178})
      : super(key: key);
  final String pregunta;
  final String respuesta;
  final double width;
  final double height;

  @override
  // ignore: library_private_types_in_public_api
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  bool isShowingAnswer = false;

  void toggleCard() {
    setState(() {
      isShowingAnswer = !isShowingAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: azulRey,
            width: 2,
          ),
        ),
        child: FlipCard(
          fill: Fill.fillBack,
          direction: FlipDirection.HORIZONTAL,
          side: CardSide.FRONT,
          front: FittedBox(
            fit: BoxFit.scaleDown,
            child: AutoSizeText(widget.pregunta,
                style: const TextStyle(
                    fontSize: 40,
                    fontFamily: "Arimo",
                    fontWeight: FontWeight.bold)),
          ),
        back: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                widget.respuesta,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Arimo",
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true, // Permitir saltos de línea
                textAlign: TextAlign.center, // Alineación horizontal centrada
              ),
            ),
          ),
        ),
      ),
      ),
      // child: Card(
      //   elevation: 4,
      //   child: InkWell(
      //     onTap: toggleCard,
      //     child: Container(
      //       width: widget.width,
      //       height: widget.height,
      //       alignment: Alignment.center,
      //       padding: EdgeInsets.all(16),
      //       child: isShowingAnswer
      // ? FittedBox(
      //     fit: BoxFit.scaleDown,
      //     child: AutoSizeText(
      //       widget.respuesta,
      //       style: const TextStyle(
      //           fontSize: 40,
      //           fontFamily: "Arimo",
      //           fontWeight: FontWeight.bold),
      //     ),
      //   )
      // : FittedBox(
      //     fit: BoxFit.scaleDown,
      //     child: AutoSizeText(widget.pregunta,
      //         style: const TextStyle(
      //             fontSize: 40,
      //             fontFamily: "Arimo",
      //             fontWeight: FontWeight.bold)),
      //   ),
      //     ),
      //   ),
      // ),
    );
  }
}
