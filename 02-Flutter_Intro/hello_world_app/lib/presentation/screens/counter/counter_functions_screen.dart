import 'package:flutter/material.dart';

/// La vista extenderá de un Stateful Widget, es decir un widget con
/// capacidad de gestión de estados, representa crucial para esta vista
/// porque solo con estos widgets podrá funcionar este contador, en donde
/// al momento de presionar un botón, la información en el UI cambie.
class CounterFunctionsScreen extends StatefulWidget {
  // Constructor del widget
  const CounterFunctionsScreen({super.key});

  // Se crea un estado del widget
  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

// Construcción del widget a partir del estado
class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  // Creamos una variable para reflejar el valor actual
  int currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Functions'),
        // Muestra widgets en forma de fila a la derecha del titulo
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                // Reiniciamos el contador
                currentValue = 0;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Mostramos el valor actual del contador
              '$currentValue',
              style: const TextStyle(
                fontSize: 160,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              // Muestra clic o clics dependiendo de currentValue
              'Clic${currentValue != 1 ? 's' : ''}',
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),

          /// Mandamos a llamar a nuesto widget personalizado
          /// 3 veces, reduciendo significativamente el código que
          /// si lo hicieramos de manera manual con cada uno. Además
          /// de que si cambiamos el estilo, cambia en todos.
          CustomFloatingButton(
            icon: Icons.refresh,
            onPressed: () {
              setState(() {
                // Se reinicia el contador
                currentValue = 0;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomFloatingButton(
            icon: Icons.plus_one,
            onPressed: () {
              setState(() {
                // Se incrementa el valor del contador
                currentValue++;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomFloatingButton(
            icon: Icons.exposure_minus_1_outlined,
            onPressed: () {
              setState(() {
                /// Si el valor actual es mayor o igual a uno se
                /// hace válida la resta
                if (currentValue >= 1) currentValue--;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Creamos un widget personalizado sin estado
class CustomFloatingButton extends StatelessWidget {
  // Definimos los parametros que vamos a recibir
  final IconData icon;
  final Function()? onPressed;

  // Se define el constructor
  const CustomFloatingButton({
    required this.icon,
    this.onPressed,
    super.key,
  });

  // Retornamos un widget ya configurado
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
