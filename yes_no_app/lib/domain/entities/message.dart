// Enumeración para determinar de quién es el mensaje
enum FromWho { me, they }

class Message {
  // Atributos de la clase
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  // Constructor de la clase
  Message({required this.text, required this.fromWho, this.imageUrl});
}
