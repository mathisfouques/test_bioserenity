import 'package:equatable/equatable.dart';
import 'package:test_bioserenity/entities/car.dart';

abstract class CarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarSelected extends CarEvent {
  CarSelected(this.car);

  final Car car;

  @override
  List<Object?> get props => [car.name];
}

class StopCar extends CarEvent {}

class CarTicked extends CarEvent {
  CarTicked(this.car);

  final Car car;

  @override
  List<Object?> get props => [car.name, car.currentSpeed];
}

class OtherCarSelected extends CarEvent {}
