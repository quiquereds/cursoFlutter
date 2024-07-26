/// Esta linea representa que este archivo es parte de counter_cubit.dart
part of 'counter_cubit.dart';

// Se borra la clase creda por Bloc para crear nuestra propia clase
class CounterState {
  // Definimos cómo va a lucir el estado del Cubit
  final int counter; // -> Valor actual del contador
  final int transactionCount; // -> No. veces que ha cambiado el counter;

  // Creamos el constructor inicializado con valores por defecto
  CounterState({
    this.counter = 0,
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
}
