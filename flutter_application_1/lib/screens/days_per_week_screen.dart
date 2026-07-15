// Importa os widgets visuais do Flutter.
import 'package:flutter/material.dart';

// Importa o serviço responsável por salvar os dados do usuário.
import '../services/auth_service.dart';

// Cria a tela onde o usuário escolhe quantos dias por semana deseja treinar.
// StatefulWidget é utilizado porque a opção selecionada pode mudar.
class DaysPerWeekScreen extends StatefulWidget {
  const DaysPerWeekScreen({super.key});

  @override
  State<DaysPerWeekScreen> createState() =>
      _DaysPerWeekScreenState();
}

// Classe responsável por controlar o estado da tela.
class _DaysPerWeekScreenState
    extends State<DaysPerWeekScreen> {

  // Armazena a quantidade de dias selecionada.
  int diasSelecionados = 1;

  // Cor principal utilizada na interface.
  final Color verde = const Color(0xFFC6FF00);

  // Método que cria um botão para cada opção de dias.
  Widget botaoDia(String texto, int valor) {

    // Verifica se este botão está selecionado.
    final bool ativo = diasSelecionados == valor;

    return GestureDetector(

      // Atualiza o número de dias quando o usuário toca no botão.
      onTap: () {
        setState(() {
          diasSelecionados = valor;
        });
      },

      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),

        decoration: BoxDecoration(
          color: ativo ? verde : const Color(0xff111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ativo ? verde : Colors.white10,
          ),
        ),

        child: Center(
          child: Text(
            texto,

            style: TextStyle(
              color: ativo ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  // Método responsável por construir toda a interface da tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Define a cor de fundo da tela.
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(

          // Permite rolar a tela caso o conteúdo seja maior que a tela.
          child: Padding(
            padding: const EdgeInsets.all(28),

            child: Column(
              children: [

                const SizedBox(height: 20),

                // Logo do aplicativo.
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [

                        // Parte "FIT".
                        const TextSpan(
                          text: "FIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Parte "PLAN".
                        TextSpan(
                          text: "PLAN",
                          style: TextStyle(
                            color: Color(0xFFC6FF00),
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Subtítulo.
                const Text(
                  "Plano de treino personalizado",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // Barra indicando o progresso do cadastro.
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        color: Color(0xFFC6FF00),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: Color(0xFFC6FF00),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: Color(0xFFC6FF00),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Título da tela.
                const Text(
                  "Dias por semana",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Texto explicativo.
                const Text(
                  "Quantos dias você pode treinar?",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // Botões para selecionar a quantidade de dias.
                botaoDia("1 Dia por Semana", 1),
                botaoDia("2 Dias por Semana", 2),
                botaoDia("3 Dias por Semana", 3),
                botaoDia("4 Dias por Semana", 4),
                botaoDia("5 Dias por Semana", 5),
                botaoDia("6 Dias por Semana", 6),
                botaoDia("7 Dias por Semana", 7),

                const SizedBox(height: 20),

                // Linha contendo os botões de navegação.
                Row(
                  children: [

                    // Retorna para a tela anterior.
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        "Voltar",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Botão para gerar o plano de treino.
                    Expanded(
                      child: SizedBox(
                        height: 60,

                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC6FF00),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),

                          // Salva a quantidade de dias escolhida e
                          // abre a próxima tela.
                          onPressed: () async {
                            try {

                              // Salva os dias no banco de dados.
                              await AuthService().salvarDiasSemana(
                                diasSelecionados,
                              );

                              // Verifica se a tela ainda está ativa.
                              if (!mounted) return;

                              // Abre a tela de montagem do treino.
                              Navigator.pushNamed(
                                context,
                                '/workout',
                                arguments: diasSelecionados,
                              );

                            } catch (e) {

                              // Exibe uma mensagem caso ocorra algum erro.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Erro ao salvar os dias: $e",
                                  ),
                                ),
                              );
                            }
                          },

                          child: const Text(
                            "GERAR MEU PLANO",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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