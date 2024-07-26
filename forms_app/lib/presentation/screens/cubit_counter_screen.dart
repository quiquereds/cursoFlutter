import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Como el CounterCubit solo va a vivir, o los widgets solo podrán acceder
    /// a el desde esta pantalla, se utiliza el BlocProvider para crear la
    /// instancia del cubit aquí. Es decir, el CounterCubit solo podrá ser
    /// accesible en el árbol de widgets de CubitCounterScreen
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    /// Una de las formas de estar escuchando los cambios del State es mediante
    /// la propiedad watch para almacenar el estado en una variable.
    final counterState = context.watch<CounterCubit>().state;

    // Creamos un método para crear una referencia al state y actualizar su valor
    void increaseCounterBy(BuildContext context, [int value = 1]) {
      context.read<CounterCubit>().increaseBy(value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cambios: ${counterState.transactionCount}'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CounterCubit>().reset();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        /// Otro método de escucha es usar un BlocBuilder
        /// indicando el Cubit y el State para que Flutter
        /// redibuje los cambios en pantalla de un determinado widget.
        child: BlocBuilder<CounterCubit, CounterState>(
          /// Creamos una condición para que solo se redibuje si el nuevo estado
          /// es diferente del estado anterior
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// Se define el hero tag para que Flutter entienda que son botones
          /// diferentes y no genere problemas.
          FloatingActionButton(
            heroTag: '1',
            child: const Text('+3'),
            onPressed: () => increaseCounterBy(context, 3),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => increaseCounterBy(context, 2),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => increaseCounterBy(context),
          ),
        ],
      ),
    );
  }
}
