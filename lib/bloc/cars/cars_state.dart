import 'package:equatable/equatable.dart';
import 'package:test_bioserenity/entities/car.dart';

enum CarsStatus { initial, success, failure }

class CarsState extends Equatable {
  const CarsState({
    this.status = CarsStatus.initial,
    this.cars = const <Car>[],
  });

  final CarsStatus status;
  final List<Car> cars;

  CarsState copyWith({
    CarsStatus? status,
    List<Car>? cars,
  }) {
    return CarsState(
      status: status ?? this.status,
      cars: cars ?? this.cars,
    );
  }

  @override
  List<Object> get props => [status, cars.hashCode];
}
