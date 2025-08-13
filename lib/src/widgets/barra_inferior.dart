import 'package:flutter/material.dart';
import 'package:study_buddy/src/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import "package:provider/provider.dart";
import "package:study_buddy/src/services/barra_inferior_service.dart";

class BarraInferior extends StatefulWidget {
  const BarraInferior({
    super.key,
  });

  @override
  State<BarraInferior> createState() => _BarraInferiorState();
}

class _BarraInferiorState extends State<BarraInferior> {
  String botonPresionado = "sustantivos";

  void cambiarBotonPresionado(String boton) {
    setState(() {
      botonPresionado = boton;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BottomBarProvider bottomBarProvider =
        Provider.of<BottomBarProvider>(context);
    String iconoActivo = bottomBarProvider.activeIcon;

    return Container(
      width: 302,
      height: 42,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: azulClaro,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/palabras");
                bottomBarProvider.setActiveIcon("palabras");
              },
              icon: Icon(
                Icons.home,
                color: iconoActivo == "palabras" ? Colors.white : azulRey,
              ),
            ),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/home");
                bottomBarProvider.setActiveIcon("home");
              },
              icon: SvgPicture.asset(
                "assets/images/cards.svg",
                colorFilter: ColorFilter.mode(
                  iconoActivo == "home" ? Colors.white : azulRey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/comunidad");
                  bottomBarProvider.setActiveIcon("comunidad");
                },
                icon: Image.asset(
                  "assets/images/comunidad.png",
                  height: 20,
                  color: iconoActivo == "comunidad" ? Colors.white : azulRey,
                )),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/ranking");
                bottomBarProvider.setActiveIcon("ranking");
              },
              icon: SvgPicture.asset(
                "assets/images/high-bars.svg",
                colorFilter: ColorFilter.mode(
                  iconoActivo == "ranking" ? Colors.white : azulRey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/user");
              bottomBarProvider.setActiveIcon("user");
            },
            icon: SvgPicture.asset(
              "assets/images/account.svg",
              colorFilter: ColorFilter.mode(
                iconoActivo == "user" ? Colors.white : azulRey,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
