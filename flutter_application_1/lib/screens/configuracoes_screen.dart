import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {

  int treinosConcluidos = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final plano = await AuthService().carregarPlano();

    setState(() {
      treinosConcluidos =
          plano.where((e) => e["concluido"] == 1).length;
    });
  }

  @override
  Widget build(BuildContext context) {

    const verde = Color(0xFFC6FF00);

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  const Expanded(
                    child: Text(
                      "Configurações",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  )

                ],
              ),

              const SizedBox(height:25),

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Conta",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:5),

                    Text(
                      "@${AuthService.nome}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )

                  ],
                ),
              ),

              const SizedBox(height:18),

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Plano atual",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:6),

                    Text(
                      "${AuthService.idade} anos • ${AuthService.peso.toStringAsFixed(0)}kg • ${AuthService.diasSemana}x/semana • $treinosConcluidos treinos realizados",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )

                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6F3600),
                    foregroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: (){

                  },

                  child: const Text(
                    "REDEFINIR PLANO DE TREINO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height:15),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2B1111),
                    foregroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: (){

                  },

                  child: const Text(
                    "SAIR DA CONTA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}