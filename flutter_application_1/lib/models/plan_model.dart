class PlanModel {
  final String objective;
  final int days;

  PlanModel({
    required this.objective,
    required this.days,
  });

  Map<String, dynamic> toMap() {
    return {
      'objective': objective,
      'days': days,
    };
  }
}