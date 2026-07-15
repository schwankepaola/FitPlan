// Importa a biblioteca do Flutter que contém os principais widgets de interface.
import 'package:flutter/material.dart';

// Cria a tela de Alertas.
// StatelessWidget é utilizado porque esta tela não possui informações que mudam durante o uso.
class AlertsScreen extends StatelessWidget {
  // Construtor da tela.
  const AlertsScreen({super.key});

  // Método responsável por construir toda a interface da tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo da tela como preta.
      backgroundColor: Colors.black,

      // Barra superior da tela.
      appBar: AppBar(
        // Define a cor da AppBar.
        backgroundColor: Colors.black,

        // Título exibido na barra superior.
        title: const Text("Alertas"),
      ),

      // Conteúdo principal da tela.
      body: const Center(
        // Centraliza o widget filho na tela.
        child: Text(
          // Mensagem exibida quando não existem alertas.
          "Nenhum alerta no momento",

          // Define a cor do texto como branca.
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}