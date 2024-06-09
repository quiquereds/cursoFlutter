import 'package:flutter/material.dart';

const List<Map<String, dynamic>> cards = [
  {
    'elevation': 0.0,
    'label': 'Elevation 0',
  },
  {
    'elevation': 1.0,
    'label': 'Elevation 1',
  },
  {
    'elevation': 2.0,
    'label': 'Elevation 2',
  },
  {
    'elevation': 3.0,
    'label': 'Elevation 3',
  },
  {
    'elevation': 4.0,
    'label': 'Elevation 4',
  },
  {
    'elevation': 5.0,
    'label': 'Elevation 5',
  },
];

class CardsScreen extends StatelessWidget {
  /// Definimos el nombre de la ruta
  /// La palabra reservada static, sirve para no crear instancias de
  /// HomeScreen al llamar a esta propiedad.
  static const String name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards screen'),
      ),
      body: _CardsView(),
    );
  }
}

class _CardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Recorremos todo el arreglo definido anteriormente y lo
          /// devolvemos en forma de widget CardType1
          ...cards.map(
            (card) => _CardType1(
              label: card['label'],
              elevation: card['elevation'],
            ),
          ),

          /// Recorremos todo el arreglo definido anteriormente y lo
          /// devolvemos en forma de widget CardType2
          ...cards.map(
            (card) => _CardType2(
              label: card['label'],
              elevation: card['elevation'],
            ),
          ),

          /// Recorremos todo el arreglo definido anteriormente y lo
          /// devolvemos en forma de widget CardType3
          ...cards.map(
            (card) => _CardType3(
              label: card['label'],
              elevation: card['elevation'],
            ),
          ),

          /// Recorremos todo el arreglo definido anteriormente y lo
          /// devolvemos en forma de widget CardType4
          ...cards.map(
            (card) => _CardType4(
              label: card['label'],
              elevation: card['elevation'],
            ),
          )
        ],
      ),
    );
  }
}

// Widgets de tarjeta con elevaciones
class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType1({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}

// Widgets de tarjetas con borde
class _CardType2 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType2({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colors.outline),
      ),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('$label (outline)'),
            )
          ],
        ),
      ),
    );
  }
}

// Widgets de tarjeta con relleno de color
class _CardType3 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType3({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.onSurfaceVariant,
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '$label (Filled)',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widgets de tarjeta con imagen
class _CardType4 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType4({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      // Evita que los hijos se salgan del diseño del padre
      clipBehavior: Clip.hardEdge,
      color: colors.onSurfaceVariant,
      elevation: elevation,
      child: Stack(
        children: [
          Image.network(
            'https://picsum.photos/id/${elevation.toInt()}/600/350',
            height: 350,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
