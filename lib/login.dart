import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003087), Color(0xFFF4A261)], // Degradado de azul oscuro a naranja
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Añadir el logo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/logo_cgo.jpg', // Asegúrate de agregar el logo en la carpeta assets
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Iniciar Sesión',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0052CC)),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            labelStyle: const TextStyle(color: Color(0xFF0052CC)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF0052CC)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFF4A261)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu correo electrónico';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(color: Color(0xFF0052CC)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF0052CC)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFF4A261)),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu contraseña';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Aumentado el tamaño del botón
                            backgroundColor: Color(0xFFF4A261), // Naranja del logo
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              } on FirebaseAuthException catch (e) {
                                String message;

                                if (e.code == 'user-not-found') {
                                  message = 'No hay ningún usuario registrado con este correo.';
                                } else if (e.code == 'wrong-password') {
                                  message = 'La contraseña es incorrecta.';
                                } else {
                                  message = 'Error al iniciar sesión. Inténtalo de nuevo.';
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            }
                          },
                          child: const Text('Iniciar Sesión'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            '¿No tienes una cuenta? Regístrate',
                            style: TextStyle(color: Color(0xFF0052CC)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}