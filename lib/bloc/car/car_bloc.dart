import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/car.dart';
import '../../services/web_socket_repository.dart';
import 'car_event.dart';
import 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc(
    this.repository,
    Car car,
  ) : super(CarState(car: car, status: CarStatus.stopped)) {
    on<StopCar>(_onStopCar);
    on<CarSelected>(_onCarSelected);
    on<CarTicked>(_onCarTicked);
    on<OtherCarSelected>(_onOtherCarSelected);
  }

  final WebSocketRepository repository;
  StreamSubscription<Car>? _carSubscription;

  FutureOr<void> _onCarTicked(CarTicked event, Emitter<CarState> emit) {
    if (state.car == event.car) {
      emit(CarState(car: event.car, status: CarStatus.running));
    }
  }

  FutureOr<void> _onCarSelected(CarSelected event, Emitter<CarState> emit) {
    repository.postCarSelectedRequest(event.car);

    _carSubscription?.cancel();
    _carSubscription = repository.carStream.listen((car) {
      if (event.car == car) {
        add(CarTicked(car));
      } else if (state.status == CarStatus.running) {
        add(OtherCarSelected());
      }
    });
  }

  FutureOr<void> _onStopCar(StopCar event, Emitter<CarState> emit) {
    emit(state.copyWith(status: CarStatus.stopped));

    repository.postStopCar();

    _carSubscription?.cancel();
  }

  FutureOr<void> _onOtherCarSelected(
      OtherCarSelected event, Emitter<CarState> emit) {
    emit(state.copyWith(status: CarStatus.stopped));
    _carSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _carSubscription?.cancel();
    return super.close();
  }
}
