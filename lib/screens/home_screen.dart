import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_bioserenity/bloc/car/car_bloc.dart';
import 'package:test_bioserenity/bloc/cars/cars_bloc.dart';
import 'package:test_bioserenity/bloc/cars/cars_event.dart';
import 'package:test_bioserenity/bloc/cars/cars_state.dart';
import 'package:test_bioserenity/widgets/car_card.dart';
import 'package:test_bioserenity/widgets/gradients_painter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: const GradientsPainter(),
        child: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            switch (state.status) {
              case CarsStatus.initial:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () =>
                          context.read<CarsBloc>().add(CarsFetch()),
                      style: Theme.of(context).textButtonTheme.style,
                      child: Text(
                        "GET CARS !",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                );
              case CarsStatus.success:
                return ListView.builder(
                  itemCount: state.cars.length,
                  itemBuilder: (context, index) {
                    return BlocProvider(
                      create: (_) => CarBloc(
                        context.read<CarsBloc>().repository,
                        state.cars[index],
                      ),
                      child: CarCard(initialCar: state.cars[index]),
                    );
                  },
                );
              case CarsStatus.failure:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text("Failure, sorry... Retry !"),
                      style: Theme.of(context).textButtonTheme.style,
                      onPressed: () =>
                          context.read<CarsBloc>().add(CarsFetch()),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
