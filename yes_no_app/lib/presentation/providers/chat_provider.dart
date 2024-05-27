import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/// ChangeNotifier permite notificar en el árbol de widgets cuando hay cambios
/// esto le permite a Flutter volver a renderizar cuando hay dicho cambio
class ChatProvider extends ChangeNotifier {
  final ScrollController chatController = ScrollController();

  // Iniciamos con dos mensajes
  List<Message> messageList = [
    Message(text: 'Hola mundo', fromWho: FromWho.me),
    Message(text: 'Holaaaa', fromWho: FromWho.they),
  ];

  // Función para enviar mensaje
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) {
      // Si el mensaje está vacio, no se añade a la lista
      return;
    }

    // Creamos el nuevo mensaje a partir del parámetro
    final newMessage = Message(text: text, fromWho: FromWho.me);

    // Añadimos el mensaje a la lista
    messageList.add(newMessage);

    // Notificamos los cambios para volver a renderizar
    notifyListeners();
    // Hacemos scroll hacia abajo
    moveScrollToBottom();
  }

  // Creamos una función de scroll para cada que haya un nuevo mensaje
  Future<void> moveScrollToBottom() async {
    // Damos un tiempo a que Flutter tenga el nuevo mensaje
    await Future.delayed(const Duration(milliseconds: 100));

    chatController.animateTo(
      // Indicamos a dónde queremos movernos
      chatController.position.maxScrollExtent,
      // Indicamos la duración del scroll
      duration: const Duration(milliseconds: 300),
      // Indicamos la animación del scroll
      curve: Curves.easeOut,
    );
  }
}
