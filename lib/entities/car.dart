import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String brand;
  final String name;
  final double speedMax;
  final double chevaux;
  final double currentSpeed;

  const Car({
    required this.brand,
    required this.name,
    required this.speedMax,
    required this.chevaux,
    required this.currentSpeed,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      brand: json['brand'],
      name: json['name'],
      speedMax: json['speedMax'],
      chevaux: json['cv'],
      currentSpeed: json['currentSpeed'],
    );
  }

  @override
  List<Object?> get props => [name];
}
