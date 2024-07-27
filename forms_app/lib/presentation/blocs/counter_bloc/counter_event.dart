part of 'counter_bloc.dart';

// Esta clase nos permite saber qué tipos de evento va a recibir el bloc
abstract class CounterEvent {
  const CounterEvent();
}

/// Creamos un evento para incrementar el valor del contador, recibiendo el valor
/// como parámetro
class CounterIncreased extends CounterEvent {
  final int valueToIncrease;

  const CounterIncreased({required this.valueToIncrease});
}

// Creamos un evento para reiniciar el contador
class CounterReset extends CounterEvent {}
