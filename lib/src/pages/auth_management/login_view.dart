import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:study_buddy/src/services/firebase_service.dart";
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/constants/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: azulClaro,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Cerrar teclado
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 50), // Modificar con diseño correspondiente
            child: ListView(
              children: [
                // This SizedBox helps to push items towards the center of the screen
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                Image.asset(
                  // Modificar con diseño correspondiente
                  "assets/icon/icon.png",
                  height: 172,
                ),
                const FormularioLogIn(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    // Modificar con diseño correspondiente
                    onPressed: () async {
                      Navigator.pushNamed(context, "/signup");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(140, 40),
                    ),
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(
                        color: azulRey,
                        fontFamily: "Arimo",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // This SizedBox helps to push items towards the center of the screen
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioLogIn extends StatefulWidget {
  const FormularioLogIn({super.key});

  @override
  State<FormularioLogIn> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogIn> {
  // Variables para formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  // Control de invisibilidad de contraseña
  bool _invisiblePassword = true;

  // Variables para guardar datos
  String _email = "";
  String _password = "";

  // Variable para controlar si se está mostrando un snackbar
  bool _isShowingSnackbar = false;

  bool _error = false;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        fontSize: 26,
                        color: azulRey,
                        fontFamily: "Arimo",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), // Modificar con diseño correspondiente
                  const Text(
                    "¡Hola, qué gusto verte de nuevo!",
                    style: TextStyle(
                      fontSize: 16,
                      color: gris,
                      fontFamily: "Arimo",
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Modificar con diseño correspondiente
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onSaved: (newValue) => _email = newValue ?? "",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Introduce texto";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Introduce un correo válido";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: estiloTextInput,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 0),
                      suffixIcon: IconButton(
                        onPressed: () => _emailController.clear(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: _invisiblePassword,
                    onSaved: (newValue) => _password = newValue ?? "",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Introduce una contraseña";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: estiloTextInput,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _invisiblePassword = !_invisiblePassword;
                        }),
                        icon: _invisiblePassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  Container(
                    width: 242,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _error
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : Colors.transparent,
                    ),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Arimo",
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 19),
          ElevatedButton(
            // Modificar con diseño correspondiente
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
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
                  await firebaseService.signInWithEmailAndPassword(
                      _email, _password);
                  if (context.mounted) {
                    Navigator.pushNamed(context, "/home");
                  }
                } on FirebaseAuthException {
                  Navigator.pop(context);
                  setState(() {
                    _error = true;
                    _errorMessage = "Credenciales incorrectas";
                    // switch (e.code) {
                    //   case "invalid-email":
                    //     _errorMessage =
                    //         "Error. Por favor ingrese un email valido.";
                    //     break;
                    //   case "user-disabled":
                    //     _errorMessage = "Error. El email está deshabilitado.";
                    //     break;
                    //   case "user-not-found":
                    //     _errorMessage = "Error. No se encontró tu cuenta.";
                    //     break;
                    //   case "wrong-password":
                    //     _errorMessage = "Error. Contraseña incorrecta.";
                    //     break;
                    //   default:
                    //     _errorMessage = "Error desconocido";
                    // }
                  });
                } catch (e) {
                  Navigator.pop(context);
                  if (!_isShowingSnackbar) {
                    _isShowingSnackbar = true;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        )
                        .closed
                        .then((_) => _isShowingSnackbar = false);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: azulRey,
              elevation: 0,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text(
              "Iniciar sesión",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Arimo",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
