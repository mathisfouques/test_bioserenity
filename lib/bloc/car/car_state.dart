import 'package:equatable/equatable.dart';
import 'package:test_bioserenity/entities/car.dart';

enum CarStatus { stopped, running, failure }

class CarState extends Equatable {
  const CarState({required this.car, required this.status});

  final CarStatus status;
  final Car car;

  CarState copyWith({
    CarStatus? status,
    Car? car,
  }) {
    return CarState(
      status: status ?? this.status,
      car: car ?? this.car,
    );
  }

  @override
  List<Object?> get props => [car.name, car.currentSpeed, status];
}
