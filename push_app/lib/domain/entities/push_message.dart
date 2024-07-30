// Creamos una entidad para almacenar las notificaciones recibidas y mostrarlas

class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl,
  });

  @override
  String toString() {
    return '''
      PushMessage id: $messageId,
      title: $title,
      body: $body,
      data: $data,
      sentDate: $sentDate,
      imageUrl: $imageUrl,
    
    ''';
  }
}
