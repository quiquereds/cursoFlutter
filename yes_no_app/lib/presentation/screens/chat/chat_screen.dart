import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/text_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        // Centrar el titulo del App bar
        centerTitle: true,
        // Espacio antes del título
        leading: const Padding(
          // Creamos un padding para darle espacio al child
          padding: EdgeInsets.all(5),
          // Creamos un circle avatar para representar un avatar dentro del chat
          child: CircleAvatar(
            // Establecemos una imágen de internet
            backgroundImage: NetworkImage(
                'https://static.wikia.nocookie.net/dualipa/images/3/31/Dua_Lipa_%28Photo%29.jpeg/revision/latest/scale-to-width-down/1200?cb=20230825000455'),
          ),
        ),
      ),
      // Creamos el body de la aplicación
      body: _ChatView(),
    );
  }
}

// Widget del cuerpo del chat screen
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Llamamos al provider de chat para estar al pendiente de los cambios
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            // Lista de mensajes (ListView)
            Expanded(
              child: ListView.builder(
                /// Enlazamos al provider al controller del ListView para
                /// indicarle que cada que exista un nuevo mensaje, se tiene
                /// que hacer scroll automaticamente hacia abajo.
                controller: chatProvider.chatController,

                /// Obtenemos el total de los mensajes en la lista message
                /// de ChatProvider
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {
                  // Creamos una instancia de la clase Message
                  final message = chatProvider.messageList[index];

                  // Validamos de quién es el mensaje para dibujarlo en pantalla
                  return (message.fromWho == FromWho.they)
                      ? const HerMeesageBubble()
                      : MyMessageBubble(message: message);
                },
              ),
            ),
            // Campo de texto para escribir mensajes (TextField)
            TextBox(
              // Le indicamos a Provider que añada un nuevo mensaje
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}
