/// Esta linea representa que este archivo es parte de counter_cubit.dart
part of 'counter_cubit.dart';

// Se borra la clase creda por Bloc para crear nuestra propia clase
class CounterState extends Equatable {
  // Definimos cómo va a lucir el estado del Cubit
  final int counter; // -> Valor actual del contador
  final int transactionCount; // -> No. veces que ha cambiado el counter;

  // Creamos el constructor inicializado con valores por defecto
  const CounterState({
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

  /// Extendemos la clase CounterState con Equatable para que nos permita comparar
  /// si dos objetos son iguales, ya que de manera tradicional, Dart hace las comparaciones
  /// con base a la direccion en memoria donde está un objeto de otro, más no de sus
  /// atributos.
  ///
  /// Al extender la clase podremos comparar el nuevo estado con el anterior para
  /// determinar si son o no iguales, y con ello, determinar si se redibujan en
  /// pantalla los cambios o no.
  ///
  /// CounterState(0,0) == CounterState(0,0)  --> True
  ///
  /// Equatable utiliza el getter props para que se especifiquen los atributos que
  /// harian a los objetos iguales entre si.
  @override
  List<Object?> get props => [counter, transactionCount];
}
