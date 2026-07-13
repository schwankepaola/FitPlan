import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Color verde = const Color(0xFFC6FF00);

  List<Map<String, dynamic>> treinos = [
    {
      'nome': 'HIIT Tabata',
      'data': '16 de jun. de 2026',
      'dia': 'Domingo',
    },
  ];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    setState(() {});
  }

  Future<void> atualizarHistorico() async {
    await carregarHistorico();
  }

  void abrirPlano() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void abrirAlertas() {
    Navigator.pushReplacementNamed(context, '/alerts');
  }

  void abrirConfiguracoes() {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: RefreshIndicator(
          color: verde,
          backgroundColor: const Color(0xFF181818),
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
                _cabecalho(),
                const SizedBox(height: 24),
                _barraNavegacao(),
                const SizedBox(height: 32),
                _cardsEstatisticas(),
                const SizedBox(height: 30),
                _tituloSemana(),
                const SizedBox(height: 16),
                _listaTreinos(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(
                text: 'FIT',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'PLAN',
                style: TextStyle(
                  color: verde,
                ),
              ),
            ],
          ),
        ),
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
          _itemNavegacao(
            icone: Icons.fitness_center,
            texto: 'Plano',
            selecionado: false,
            onTap: abrirPlano,
          ),
          _itemNavegacao(
            icone: Icons.history,
            texto: 'Histórico',
            selecionado: true,
            onTap: () {},
          ),
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
              Icon(
                icone,
                size: 17,
                color: selecionado
                    ? Colors.white
                    : Colors.white38,
              ),
              const SizedBox(width: 7),
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

  Widget _cardsEstatisticas() {
    final int quantidadeTreinos = treinos.length;
    final int quantidadeSemanas = treinos.isEmpty ? 0 : 1;

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

  Widget _cardEstatistica({
    required String valor,
    required String texto,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.08,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            valor,
            style: TextStyle(
              color: verde,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
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
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: verde.withValues(
              alpha: 0.15,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${treinos.length} treino',
            style: TextStyle(
              color: verde,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _listaTreinos() {
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
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    final List<Widget> cards = [];

    for (final treino in treinos) {
      cards.add(
        _cardTreino(treino),
      );
    }

    return Column(
      children: cards,
    );
  }

  Widget _cardTreino(
    Map<String, dynamic> treino,
  ) {
    final String nome =
        treino['nome']?.toString() ?? 'Treino';

    final String data =
        treino['data']?.toString() ?? '';

    final String dia =
        treino['dia']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: verde.withValues(
                alpha: 0.12,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: verde,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: verde.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              dia,
              style: TextStyle(
                color: verde,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}