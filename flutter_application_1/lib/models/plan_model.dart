// Modelo que representa um plano de treino do usuário.
class PlanModel {
  // Objetivo escolhido (ex.: Emagrecer, Hipertrofia, etc.).
  final String objective;

  // Quantidade de dias de treino por semana.
  final int days;

  PlanModel({
    required this.objective,
    required this.days,
  });

  // Converte o objeto em um mapa para ser armazenado no banco de dados.
  Map<String, dynamic> toMap() {
    return {
      'objective': objective,
      'days': days,
    };
  }
}