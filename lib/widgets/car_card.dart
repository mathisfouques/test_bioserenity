import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:test_bioserenity/bloc/car/car_bloc.dart';
import 'package:test_bioserenity/bloc/car/car_event.dart';
import 'package:test_bioserenity/bloc/car/car_state.dart';
import 'package:test_bioserenity/entities/car.dart';
import 'package:test_bioserenity/utils.dart';

class CarCard extends StatefulWidget {
  const CarCard({Key? key, required this.initialCar}) : super(key: key);

  final Car initialCar;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Ink(
        child: InkWell(
          onTap: () {
            if (context.read<CarBloc>().state.status != CarStatus.running) {
              context.read<CarBloc>().add(CarSelected(widget.initialCar));
            } else {
              context.read<CarBloc>().add(StopCar());
            }
          },
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${widget.initialCar.brand} ${widget.initialCar.name}",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 16),
                          Text(
                              "${widget.initialCar.chevaux} chevaux, capée à ${widget.initialCar.speedMax} km/h.",
                              style: Theme.of(context).textTheme.headline2)
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BlocBuilder<CarBloc, CarState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 100),
                                    child: LottieBuilder.asset(
                                      'assets/car.json',
                                      animate:
                                          state.status == CarStatus.running,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    "${truncateToOneDecimal(state.car.currentSpeed)} km/h",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
