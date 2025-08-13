import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';

class CreaPalabras extends StatefulWidget {
  final String palabra;
  final bool isSelected;
  final Function onTap;

  const CreaPalabras({Key? key, 
  required this.palabra, 
  required this.isSelected, 
  required this.onTap});

  @override
  State<CreaPalabras> createState() => _CreaPalabrasState();
}

class _CreaPalabrasState extends State<CreaPalabras> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          widget.onTap();
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isSelected ? azulClaro : Colors.white, // Usar la propiedad isSelected
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: const BorderSide(color: azulRey, width: 4),
        ),

        child: Text(
          widget.palabra,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "Arimo",
              fontWeight: FontWeight.bold,
              fontSize: 32),
        ),
      ),
    );
  }
}
