import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela onde o usuário informa sua idade e peso.
class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  // Controladores dos campos de idade e peso.
  final idadeController = TextEditingController();
  final pesoController = TextEditingController();

  // Cor principal utilizada na interface.
  final Color verde = const Color(0xFFC6FF00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Logo do aplicativo.
                Center(
                  child: RichText(
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
                ),

                const Center(
                  child: Text(
                    "Plano de treino personalizado",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 50),

                // Barra indicando o progresso do cadastro.
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: verde,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: verde,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                const Text(
                  "Seus dados",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Para ajustar a intensidade do treino.",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),

                const SizedBox(height: 40),

                const Text(
                  "IDADE",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Campo para informar a idade.
                TextField(
                  controller: idadeController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Ex: 25",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xff1b1b1b),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "PESO (kg)",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Campo para informar o peso.
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Ex: 75",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xff1b1b1b),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Voltar",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Botão para salvar os dados e continuar.
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verde,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {

                            // Verifica se os campos foram preenchidos.
                            if (idadeController.text.isEmpty ||
                                pesoController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Preencha idade e peso."),
                                ),
                              );
                              return;
                            }

                            try {

                              // Salva idade e peso do usuário.
                              await AuthService().salvarDadosUsuario(
                                idade: int.parse(idadeController.text),
                                peso: double.parse(
                                  pesoController.text.replaceAll(',', '.'),
                                ),
                              );

                              if (!mounted) return;

                              // Avança para a tela de escolha dos dias de treino.
                              Navigator.pushNamed(context, '/days');

                            } catch (e) {

                              // Exibe uma mensagem caso ocorra algum erro.
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Erro ao salvar os dados: $e"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "CONTINUAR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}