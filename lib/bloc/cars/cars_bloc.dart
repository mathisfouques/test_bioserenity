import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bioserenity/bloc/car/car_state.dart';
import 'package:test_bioserenity/services/web_socket_repository.dart';

import 'cars_event.dart';
import 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc(this.repository) : super(const CarsState()) {
    on<CarsFetch>(_onCarsFetch);
  }

  final WebSocketRepository repository;

  Future<void> _onCarsFetch(
    CarsFetch event,
    Emitter<CarsState> emit,
  ) async {
    final cars = await repository.lastCars.onError((error, stackTrace) {
      emit(state.copyWith(status: CarsStatus.failure));
      return [];
    });

    emit(CarsState(cars: cars, status: CarsStatus.success));
  }
}
