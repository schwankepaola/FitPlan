import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List historico = [];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    final db = await DatabaseHelper.getDatabase();

    final data = await db.query(
      'historico',
      orderBy: 'id DESC',
    );

    setState(() {
      historico = data;
    });
  }

  Future<void> refresh() async {
    await carregarHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico")),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: historico.isEmpty
            ? const Center(child: Text("Nenhum treino ainda"))
            : ListView.builder(
                itemCount: historico.length,
                itemBuilder: (context, index) {
                  final item = historico[index];

                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(item['treino']),
                    subtitle: Text(item['data']),
                  );
                },
              ),
      ),
    );
  }
}
