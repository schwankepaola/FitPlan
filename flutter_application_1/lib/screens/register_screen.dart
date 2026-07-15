import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela de cadastro de novos usuários.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores dos campos de usuário e senha.
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  // Chave utilizada para validar o formulário.
  final _formKey = GlobalKey<FormState>();

  // Cor principal da interface.
  final Color verde = const Color(0xFFC6FF00);

  // Controla se a senha será exibida ou ocultada.
  bool mostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),

            // Formulário de cadastro.
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),

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
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 8),

                  const Text(
                    "Plano de treino personalizado",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 35),

                  // Alterna entre as telas de login e cadastro.
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xff1b1b1f),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text(
                                "Entrar",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Criar conta",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  campoTitulo("USUÁRIO"),

                  // Campo para digitar o nome de usuário.
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite seu usuário";
                      }
                      return null;
                    },
                    decoration: campoDecoracao("Seu nome de usuário"),
                  ),

                  const SizedBox(height: 25),

                  campoTitulo("SENHA"),

                  // Campo para digitar a senha.
                  TextFormField(
                    controller: passwordController,
                    obscureText: !mostrarSenha,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite uma senha";
                      }
                      if (value.length < 4) {
                        return "A senha deve ter no mínimo 4 caracteres";
                      }
                      return null;
                    },
                    decoration: campoDecoracao(
                      "Mínimo 4 caracteres",
                    ).copyWith(

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
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Botão para criar a conta.
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () async {

                        // Verifica se os campos foram preenchidos corretamente.
                        if (!_formKey.currentState!.validate()) return;

                        try {

                          // Cadastra o usuário.
                          await AuthService().cadastrar(
                            nameController.text,
                            passwordController.text,
                          );

                          // Realiza o login automaticamente.
                          await AuthService().login(
                            nameController.text,
                            passwordController.text,
                          );

                          if (!mounted) return;

                          // Avança para a próxima etapa.
                          Navigator.pushReplacementNamed(
                            context,
                            '/objective',
                          );

                        } catch (e) {

                          // Exibe uma mensagem caso ocorra algum erro.
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erro ao cadastrar: $e"),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "CRIAR CONTA",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verde,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Informação sobre o armazenamento dos dados.
                  const Text(
                    "Dados salvos localmente no dispositivo.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Cria o título utilizado acima dos campos do formulário.
  Widget campoTitulo(String texto) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Define a aparência padrão dos campos de texto.
  InputDecoration campoDecoracao(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xff151515),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}