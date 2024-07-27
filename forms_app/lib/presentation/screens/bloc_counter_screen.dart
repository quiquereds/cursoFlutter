import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Al igual que con el CubitCounter, el BlocCounter también solo existirá
    /// dentro del árbol de widgets de este screen y no hay necesidad de que
    /// el acceso a su estado sea de manera global.
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  // Creamos una función para incrementar el valor del contador
  void increaseCounterBy(BuildContext context, [int value = 1]) {
    // Usamos el método .add para emitir un nuevo evento
    context.read<CounterBloc>().add(CounterIncreased(valueToIncrease: value));
  }

  // Creamos una función para reiniciar el contador
  void counterReset(BuildContext context) {
    // Posteamos el evento
    context.read<CounterBloc>().add(CounterReset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (CounterBloc bloc) =>
              Text('Cambios (Bloc): ${bloc.state.transactionCount}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              counterReset(context);
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        /// Una de las maneras de acceder al estado de los Cubits o Blocs, es de igual
        /// formna con el context.select para escuchar los cambios del CounterBloc y
        /// acceder a su state.
        child: context.select(
            (CounterBloc bloc) => Text('Conter value: ${bloc.state.counter}')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// Se define el hero tag para que Flutter entienda que son botones
          /// diferentes y no genere problemas.
          FloatingActionButton(
            heroTag: '1',
            child: const Text('+3'),
            onPressed: () {
              increaseCounterBy(context, 3);
            },
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () {
              increaseCounterBy(context, 2);
            },
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () {
              increaseCounterBy(context);
            },
          ),
        ],
      ),
    );
  }
}
