import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/// ChangeNotifier permite notificar en el árbol de widgets cuando hay cambios
/// esto le permite a Flutter volver a renderizar cuando hay dicho cambio
class ChatProvider extends ChangeNotifier {
  // Iniciamos con dos mensajes
  List<Message> message = [
    Message(text: 'Hola mundo', fromWho: FromWho.me),
    Message(text: 'Holaaaa', fromWho: FromWho.they),
  ];

  // Función para enviar mensaje
  Future<void> sendMessage(String text) async {}
}
