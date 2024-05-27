import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class HerMeesageBubble extends StatelessWidget {
  final Message message;

  const HerMeesageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // Recuperamos el tema de la app
    final colors = Theme.of(context).colorScheme;

    // Burbuja de texto
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text,
              style: TextStyle(
                color: colors.onPrimary,
              ),
            ),
          ),
        ),

        // Espacio
        const SizedBox(height: 5),

        // Imagen

        ImageBubble(
          image: message.imageUrl!,
        ),

        // Espacio
        const SizedBox(height: 20),
      ],
    );
  }
}

// Creamos un widget para mostrar imágenes
class ImageBubble extends StatelessWidget {
  final String image;

  const ImageBubble({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    // Recuperamos las dimensiones del dispositivo
    final size = MediaQuery.of(context).size;

    // Enmarcamos la imagen dentro de un widget con bordes redondeados
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image,

        /// Hacemos que las dimensiones de la imagen sean proporcionales y no
        /// ocupen todo el ancho y alto de la pantalla
        width: size.width * 0.7,
        height: 150,
        // Ajustamos la imagen al ClipRRect
        fit: BoxFit.cover,
        // Mostrar widget mientras se carga la imágen
        loadingBuilder: (context, child, loadingProgress) {
          /// Creamos un bloque if para determinar si la imagen ya cargó
          /// y determinar qué devolver
          if (loadingProgress == null) {
            // Si el contenido ya cargó, se regresa el child
            return child;
          }
          // Si no ha cargado, se regresa un container
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Te están enviando una imagen'),
          );
        },
      ),
    );
  }
}
