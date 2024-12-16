class User {
  // Atributos de la clase
  String id;
  String email;
  String fullName;
  bool isActive;
  List<String> roles;
  String token;

  // Constructor de la clase
  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.isActive,
    required this.roles,
    required this.token,
  });

  // Getter para determinar si el usuario es administrador
  bool get isAdmin => roles.contains('admin');
}
