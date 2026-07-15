import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela de configurações e perfil do usuário.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Cor principal utilizada na interface.
    final Color verde = const Color(0xFFC6FF00);

    // Obtém os dados do usuário salvos no AuthService.
    final String nome =
        AuthService.nome.isEmpty ? "paola" : AuthService.nome;

    final int idade = AuthService.idade;
    final double peso = AuthService.peso;
    final int dias = AuthService.diasSemana;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 22,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // Cabeçalho da tela com título e botão para fechar.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Configurações",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(14),

                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: Container(
                      width: 44,
                      height: 44,

                      decoration: BoxDecoration(
                        color: const Color(0xff202020),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.close,
                        color: Colors.white54,
                      ),
                    ),
                  )

                ],
              ),

              const SizedBox(height:35),

              // Card com as informações da conta.
              Container(

                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Conta",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:8),

                    Text(
                      "@$nome",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height:18),

              // Card com os dados do plano atual.
              Container(

                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Plano atual",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:8),

                    Text(
                      "$idade anos · ${peso.toStringAsFixed(0)}kg · ${dias}x/semana",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Botão para apagar o plano atual e criar um novo.
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4A250D),
                    foregroundColor: const Color(0xFFFF7A00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        color: Color(0xff8B4513),
                      ),
                    ),
                  ),
                  onPressed: () async {

                    // Remove o plano salvo.
                    await AuthService().limparPlano();

                    // Retorna para a tela de escolha do objetivo.
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/objective",
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    "REDEFINIR PLANO DE TREINO",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Botão para sair da conta.
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "SAIR DA CONTA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff341616),
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        color: Color(0xff5B1F1F),
                      ),
                    ),
                  ),
                  onPressed: () {

                    // Remove o usuário logado e retorna para a tela de login.
                    AuthService.usuarioLogado = null;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/login",
                      (route) => false,
                    );
                  },
                ),
              ),

              const Spacer(),

              // Nome do aplicativo exibido no rodapé.
              Center(
                child: Text(
                  "FITPLAN",
                  style: TextStyle(
                    color: verde.withOpacity(0.45),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}