part of 'counter_bloc.dart';

// Definimos cómo va a lucir el estado del Bloc
class CounterState extends Equatable {
  final int counter;
  final int transactionCount;

  const CounterState({
    this.counter = 5,
    this.transactionCount = 0,
  });

  /// Método para emitir un nuevo estado (copia del estado actual + nuevo estado)
  /// usando el helper copyWith
  copyWith({
    int? counter,
    int? transactionCount,
  }) =>

      /// Devolvemos un nuevo estado con los valores recibidos, en caso de ser nulos,
      /// se usan los valores del estado anterior.
      CounterState(
        counter: counter ?? this.counter,
        transactionCount: transactionCount ?? this.transactionCount,
      );

  @override
  List<Object> get props => [counter, transactionCount];
}
