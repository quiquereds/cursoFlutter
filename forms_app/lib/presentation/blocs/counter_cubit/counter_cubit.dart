import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

// Creamos la clase del CounterCubit con la instancia del CounterState
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counter: 5));

  // Creamos métodos para manipular el Cubit
  void increaseBy(int value) {
    // Incrementamos el estado usando la función emit para crear un nuevo estado
    emit(state.copyWith(
      counter: state.counter + value,
      transactionCount: state.transactionCount + 1,
    ));
  }

  void reset() {
    // Reiniciamos el contador a 0
    emit(state.copyWith(
      counter: 0,
    ));
  }
}
