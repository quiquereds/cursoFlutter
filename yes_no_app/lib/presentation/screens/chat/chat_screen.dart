import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            // Lista de mensajes (ListView)
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  // Alternamos entre mensajes
                  /// Para ello, buscamos si el indice actual es
                  /// divisible entre 2 (par o impar)
                  return (index % 2 == 0)
                      ? const HerMeesageBubble()
                      : const MyMessageBubble();
                },
              ),
            ),
            // Campo de texto para escribir mensajes (TextField)
          ],
        ),
      ),
    );
  }
}
