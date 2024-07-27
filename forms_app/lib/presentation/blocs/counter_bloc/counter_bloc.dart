import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // Inicialización del counter bloc con su respectivo estado inicial
  CounterBloc() : super(const CounterState()) {
    /// Desde aqui empiezan los manejadores de cada uno de los eventos definidos
    /// en el archivo counter_event.dart

    // Manejador de un Counter Increased
    on<CounterIncreased>(_onCounterIncreased);
    // Manejador de un CounterReset
    on<CounterReset>(_onCounterReset);
  }

  void _onCounterIncreased(CounterIncreased event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: state.counter + event.valueToIncrease,
      transactionCount: state.transactionCount + 1,
    ));
  }

  void _onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: 0,
    ));
  }
}
