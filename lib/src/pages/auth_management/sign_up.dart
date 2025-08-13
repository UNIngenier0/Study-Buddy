import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:study_buddy/src/services/firebase_service.dart";
import "package:study_buddy/src/services/firestore_service.dart";
import 'package:study_buddy/src/constants/colors.dart';
import 'package:study_buddy/src/constants/styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset(
                  "assets/icon/icon.png",
                  height: 163,
                ),
                const FormularioRegistro(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    // Modificar con diseño correspondiente
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
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
                      "Iniciar Sesión",
                      style: TextStyle(
                        color: azulRey,
                        fontFamily: "Arimo",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({super.key});

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  // Controladores del texto
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Llave del formulario
  final _formKey = GlobalKey<FormState>();

  bool _invisiblePassword = true;
  bool _invisibleConfirmedPassword = true;

  // Variables donde se guardará la información del formulario
  String _user = "";
  String _email = "";
  String _password = "";

  bool _isShowingSnackbar = false;
  bool _error = false;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: 437,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Registro",
                        style: TextStyle(
                          fontSize: 26,
                          color: azulRey,
                          fontFamily: "Arimo",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // Modificar con diseño correspondiente
                    const Text(
                      "¡Bienvenido a una nueva experiencia de aprendizaje!",
                      style: TextStyle(
                        fontSize: 16,
                        color: gris,
                        fontFamily: "Arimo",
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Modificar con diseño correspondiente
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _userController,
                      onSaved: (newValue) => _user = newValue ?? "",
                      decoration: InputDecoration(
                        labelText: "Usuario",
                        labelStyle: estiloTextInput,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _userController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce un usuario";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      onSaved: (newValue) => _email = newValue ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce un correo";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          setState(() {
                            _error = true;
                            _errorMessage =
                                "Error. Por favor ingresa un email valido.";
                          });
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
                      controller: _passwordController,
                      obscureText: _invisiblePassword,
                      onSaved: (newValue) => _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce una contraseña";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        labelStyle: estiloTextInput,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 0),
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
                    TextFormField(
                      obscureText: _invisibleConfirmedPassword,
                      onSaved: (newValue) => _password = newValue ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce una contraseña";
                        }
                        if (value != _passwordController.text) {
                          setState(() {
                            _error = true;
                            _errorMessage =
                                "Error. Las contraseñas no son iguales.";
                          });
                          return "Las contraseñas no coinciden";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirmar Contraseña",
                        labelStyle: estiloTextInput,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 0),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _invisibleConfirmedPassword =
                                !_invisibleConfirmedPassword;
                          }),
                          icon: _invisibleConfirmedPassword
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    // Contenedor con el error
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
                      child: _error
                          ? Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Arimo",
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 19),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: azulRey,
              elevation: 0,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 40),
            ),
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
                  await firebaseService.createUserWithEmailAndPassword(
                      _email, _password);
                  await firestoreService.createUser(
                      firebaseService.user!.uid, _user);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Usuario creado"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                  await Future.delayed(const Duration(milliseconds: 2000));
                  if (context.mounted) {
                    Navigator.pushNamed(context, "/login");
                  }
                } catch (e) {
                  if (firebaseService.user != null) {
                    await firebaseService.deleteUser(firebaseService.user);
                  }

                  if (e is FirebaseAuthException) {
                    setState(() {
                      _error = true;
                      switch (e.code) {
                        case "email-already-in-use":
                          _errorMessage = "Error. El email ya está en uso.";
                          break;
                        case "invalid-email":
                          _errorMessage = "El correo no es válido";
                          break;
                        case "weak-password":
                          _errorMessage =
                              "Error. La contraseña no es lo suficientemente fuerte. Debe tener 6 caracteres mínimo.";
                          break;
                        case "operation-not-allowed":
                          _errorMessage =
                              "Error. El email y la contraseña no están habilitados.";
                          break;
                        default:
                          _errorMessage = "Error en la creación del usuario";
                      }
                    });
                  } else {
                    _errorMessage = e.toString();
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  if (!_isShowingSnackbar) {
                    _isShowingSnackbar = true;
                    if (context.mounted) {
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
              }
            },
            child: const Text(
              "Crear usuario",
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
