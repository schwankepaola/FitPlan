// Modelo que representa um treino associado a um dia da semana.
class WorkoutModel {
  // Dia em que o treino será realizado.
  final String day;

  // Nome ou tipo do treino.
  final String workout;

  WorkoutModel({
    required this.day,
    required this.workout,
  });

  // Converte o objeto em um mapa para armazenamento no banco de dados.
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'workout': workout,
    };
  }
}