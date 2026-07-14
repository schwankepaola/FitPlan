// Modelo que representa um usuário da aplicação.
class UserModel {
  // Identificador único do usuário.
  final String uid;

  // Nome do usuário.
  final String name;

  // E-mail utilizado no cadastro.
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  // Converte o objeto em um mapa para facilitar o armazenamento no banco.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  // Cria um objeto UserModel a partir dos dados recuperados do banco.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
    );
  }
}