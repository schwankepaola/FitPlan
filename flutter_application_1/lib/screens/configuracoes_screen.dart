// Importa os widgets visuais do Flutter.
import 'package:flutter/material.dart';

// Importa o serviço responsável por acessar os dados do usuário.
import '../services/auth_service.dart';

// Cria a tela de Configurações.
// StatefulWidget é utilizado porque algumas informações da tela podem mudar,
// como a quantidade de treinos concluídos.
class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

// Classe que controla o estado da tela.
class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {

  // Armazena a quantidade de treinos concluídos pelo usuário.
  int treinosConcluidos = 0;

  // Executado quando a tela é aberta.
  @override
  void initState() {
    super.initState();

    // Carrega os dados do usuário.
    carregarDados();
  }

  // Busca o plano de treino salvo e conta quantos treinos foram concluídos.
  Future<void> carregarDados() async {

    // Obtém o plano salvo no banco de dados.
    final plano = await AuthService().carregarPlano();

    // Atualiza a interface com a quantidade de treinos concluídos.
    setState(() {
      treinosConcluidos =
          plano.where((e) => e["concluido"] == 1).length;
    });
  }

  // Método responsável por construir toda a interface da tela.
  @override
  Widget build(BuildContext context) {

    // Cor verde definida para possível uso na interface.
    const verde = Color(0xFFC6FF00);

    return Scaffold(

      // Define o fundo da tela como preto.
      backgroundColor: Colors.black,

      body: SafeArea(

        // Evita que o conteúdo fique atrás da barra de status do celular.
        child: Padding(

          // Espaçamento ao redor de todo o conteúdo.
          padding: const EdgeInsets.all(18),

          child: Column(

            // Alinha os widgets à esquerda.
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // Linha superior contendo o título e o botão de fechar.
              Row(
                children: [

                  // Faz o título ocupar todo o espaço disponível.
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

                  // Botão para fechar a tela.
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

              // Espaço entre os elementos.
              const SizedBox(height:25),

              // Cartão com as informações da conta.
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Título da seção.
                    const Text(
                      "Conta",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:5),

                    // Exibe o nome do usuário logado.
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

              // Cartão com as informações do plano atual.
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Título da seção.
                    const Text(
                      "Plano atual",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height:6),

                    // Exibe idade, peso, frequência semanal e treinos concluídos.
                    Text(
                      "${AuthService.idade} anos • ${AuthService.peso.toStringAsFixed(0)}kg • ${AuthService.diasSemana}x/semana • $treinosConcluidos treinos realizados",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )

                  ],
                ),
              ),

              // Empurra os botões para o final da tela.
              const Spacer(),

              // Botão para redefinir o plano de treino.
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  // Define a aparência do botão.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6F3600),
                    foregroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  // Ação executada ao clicar no botão.
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

              // Botão para sair da conta.
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  // Define a aparência do botão.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2B1111),
                    foregroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  // Ação executada ao clicar no botão.
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