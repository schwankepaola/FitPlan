// Importa os widgets visuais do Flutter.
import 'package:flutter/material.dart';

// Importa o serviço responsável por acessar os dados do usuário e do histórico.
import '../services/auth_service.dart';

// Cria a tela de Histórico.
// StatefulWidget é utilizado porque os dados do histórico podem ser atualizados.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

// Classe responsável por controlar o estado da tela.
class _HistoryScreenState extends State<HistoryScreen> {

  // Cor principal utilizada na interface.
  final Color verde = const Color(0xFFC6FF00);

  // Lista que armazenará todos os treinos concluídos.
  List<Map<String, dynamic>> treinos = [];

  // Executado quando a tela é aberta.
  @override
  void initState() {
    super.initState();

    // Carrega o histórico de treinos.
    carregarHistorico();
  }

  // Busca o histórico salvo no banco de dados.
  Future<void> carregarHistorico() async {

    treinos = await AuthService().carregarHistorico();

    // Atualiza a interface caso a tela ainda esteja aberta.
    if (mounted) {
      setState(() {});
    }
  }

  // Atualiza o histórico ao puxar a tela para baixo.
  Future<void> atualizarHistorico() async {
    await carregarHistorico();
  }

  // Abre a tela principal do plano de treino.
  void abrirPlano() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  // Abre a tela de alertas.
  void abrirAlertas() {
    Navigator.pushReplacementNamed(context, '/alerts');
  }

  // Abre a tela de configurações.
  void abrirConfiguracoes() {
    Navigator.pushNamed(context, '/profile');
  }

  // Constrói toda a interface da tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Cor de fundo.
      backgroundColor: Colors.black,

      body: SafeArea(
        child: RefreshIndicator(

          // Cor do indicador de atualização.
          color: verde,
          backgroundColor: const Color(0xFF181818),

          // Atualiza os dados ao puxar a tela.
          onRefresh: atualizarHistorico,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // Cabeçalho da tela.
                _cabecalho(),

                const SizedBox(height: 24),

                // Barra de navegação.
                _barraNavegacao(),

                const SizedBox(height: 32),

                // Cards com estatísticas.
                _cardsEstatisticas(),

                const SizedBox(height: 30),

                // Título da semana.
                _tituloSemana(),

                const SizedBox(height: 16),

                // Lista dos treinos realizados.
                _listaTreinos(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Cabeçalho contendo o logo, saudação e botão de configurações.
  Widget _cabecalho() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // Logo FITPLAN.
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(
                text: 'FIT',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'PLAN',
                style: TextStyle(color: verde),
              ),
            ],
          ),
        ),

        // Saudação e botão de configurações.
        Row(
          children: [
            const Text(
              'Olá, Paola',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 12),

            InkWell(

              // Abre as configurações.
              onTap: abrirConfiguracoes,

              borderRadius: BorderRadius.circular(12),

              child: Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: const Color(0xFF181818),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Barra de navegação entre Plano, Histórico e Alertas.
  Widget _barraNavegacao() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),

      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [

          // Botão Plano.
          _itemNavegacao(
            icone: Icons.fitness_center,
            texto: 'Plano',
            selecionado: false,
            onTap: abrirPlano,
          ),

          // Botão Histórico.
          _itemNavegacao(
            icone: Icons.history,
            texto: 'Histórico',
            selecionado: true,
            onTap: () {},
          ),

          // Botão Alertas.
          _itemNavegacao(
            icone: Icons.notifications_none,
            texto: 'Alertas',
            selecionado: false,
            onTap: abrirAlertas,
          ),
        ],
      ),
    );
  }

  // Método que cria um item da barra de navegação.
  Widget _itemNavegacao({
    required IconData icone,
    required String texto,
    required bool selecionado,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(11),

        child: Container(
          height: double.infinity,

          decoration: BoxDecoration(
            color: selecionado
                ? const Color(0xFF0D0D0D)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // Ícone.
              Icon(
                icone,
                size: 17,
                color: selecionado
                    ? Colors.white
                    : Colors.white38,
              ),

              const SizedBox(width: 7),

              // Texto.
              Text(
                texto,
                style: TextStyle(
                  color: selecionado
                      ? Colors.white
                      : Colors.white38,
                  fontSize: 13,
                  fontWeight: selecionado
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cria os cards com as estatísticas do usuário.
  Widget _cardsEstatisticas() {

    // Quantidade total de treinos.
    final int quantidadeTreinos = treinos.length;

    // Calcula aproximadamente quantas semanas de treino existem.
    final int quantidadeSemanas =
        quantidadeTreinos == 0
            ? 0
            : (quantidadeTreinos / 7).ceil();

    return Row(
      children: [

        Expanded(
          child: _cardEstatistica(
            valor: '$quantidadeTreinos',
            texto: 'treinos',
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _cardEstatistica(
            valor: '$quantidadeTreinos',
            texto: 'treinos',
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _cardEstatistica(
            valor: '$quantidadeSemanas',
            texto: 'semanas',
          ),
        ),
      ],
    );
  }

  // Cria um card de estatística.
  Widget _cardEstatistica({
    required String valor,
    required String texto,
  }) {
    return Container(
      height: 100,

      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          // Valor principal.
          Text(
            valor,
            style: TextStyle(
              color: verde,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 4),

          // Descrição.
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Exibe o título da semana.
  Widget _tituloSemana() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        const Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.white38,
              size: 15,
            ),

            SizedBox(width: 8),

            Text(
              'SEMANA 25 DE 2026',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        // Quantidade de treinos cadastrados.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          decoration: BoxDecoration(
            color: verde.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Text(
            '${treinos.length} treino',
            style: TextStyle(
              color: verde,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  // Exibe todos os treinos realizados.
  Widget _listaTreinos() {

    // Caso não exista histórico.
    if (treinos.isEmpty) {

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),

        decoration: BoxDecoration(
          color: const Color(0xFF101010),
          borderRadius: BorderRadius.circular(14),
        ),

        child: const Column(
          children: [

            Icon(
              Icons.fitness_center,
              color: Colors.white24,
              size: 35,
            ),

            SizedBox(height: 12),

            Text(
              'Nenhum treino concluído',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      );
    }

    // Lista onde serão adicionados os cards.
    final List<Widget> cards = [];

    // Cria um card para cada treino.
    for (final treino in treinos) {
      cards.add(_cardTreino(treino));
    }

    return Column(children: cards);
  }

  // Cria o card de um treino.
  Widget _cardTreino(Map<String, dynamic> treino) {

    // Nome do treino.
    final String nome =
        treino['treino']?.toString() ?? 'Treino';

    // Data do treino.
    final DateTime dataTreino =
        DateTime.tryParse(
              treino['data']?.toString() ?? '',
            ) ??
            DateTime.now();

    // Data formatada.
    final String data =
        "${dataTreino.day}/${dataTreino.month}/${dataTreino.year}";

    // Lista com os dias da semana.
    final List<String> diasSemana = [
      "Segunda",
      "Terça",
      "Quarta",
      "Quinta",
      "Sexta",
      "Sábado",
      "Domingo",
    ];

    // Obtém o nome do dia da semana.
    final String dia =
        diasSemana[dataTreino.weekday - 1];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [

          // Ícone indicando treino concluído.
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: verde.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.check_circle_outline,
              color: verde,
            ),
          ),

          const SizedBox(width: 14),

          // Nome e data do treino.
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),

          // Dia da semana.
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: verde.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              dia,
              style: TextStyle(
                color: verde,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}