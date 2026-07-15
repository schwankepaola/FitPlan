import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela de login do aplicativo.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores dos campos de usuário e senha.
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // Controla se a senha será exibida ou ocultada.
  bool mostrarSenha = false;

  // Cor principal utilizada na interface.
  final Color verde = const Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo do aplicativo.
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: verde,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Text(
                      "FP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Nome do aplicativo.
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "FIT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "PLAN",
                        style: TextStyle(
                          color: verde,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  "Plano de treino personalizado",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Alterna entre a tela de login e cadastro.
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xff1b1b1f),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Center(
                            child: Text(
                              "Criar conta",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "USUÁRIO",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Campo para digitar o nome de usuário.
                TextField(
                  controller: usuarioController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Seu nome de usuário",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xff151515),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SENHA",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Campo para digitar a senha.
                TextField(
                  controller: senhaController,
                  obscureText: !mostrarSenha,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Mínimo 4 caracteres",
                    hintStyle: const TextStyle(color: Colors.grey),

                    // Botão para mostrar ou ocultar a senha.
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarSenha
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          mostrarSenha = !mostrarSenha;
                        });
                      },
                    ),

                    filled: true,
                    fillColor: const Color(0xff151515),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Botão para realizar o login.
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verde,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      // Verifica se o usuário e a senha estão corretos.
                      bool usuarioExiste = await AuthService().login(
                        usuarioController.text,
                        senhaController.text,
                      );

                      if (!mounted) return;

                      if (usuarioExiste) {
                        // Login realizado com sucesso.
                        Navigator.pushReplacementNamed(
                          context,
                          '/objective',
                        );
                      } else {
                        // Exibe mensagem de erro.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Usuário ou senha incorretos',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Informação sobre onde os dados são armazenados.
                const Text(
                  "Dados salvos localmente no dispositivo.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}