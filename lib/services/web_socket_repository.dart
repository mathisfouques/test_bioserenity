import 'dart:async';
import 'dart:convert';

import 'package:rxdart/subjects.dart';

import '../entities/car.dart';
import '../entities/request.dart';
import 'web_socket_client.dart';

class WebSocketRepository {
  final WebSocketClient client = WebSocketClient();

  Sink<dynamic> get carSink => client.channel.sink;

  late StreamController<dynamic> broadcastStreamController = BehaviorSubject()
    ..addStream(client.channel.stream);

  late Stream<Car> carStream = broadcastStreamController.stream
      .map<dynamic>((event) => jsonDecode(event))
      .where((event) => event["type"] == "running")
      .map<Car>((event) => Car.fromJson(event["payload"]));

  void postCarSelectedRequest(Car car) {
    final Request _request = Request(
      RequestType.start,
      payload: {"name": car.name},
    );

    carSink.add(_request.toJsonRequest);
  }

  void postStopCar() {
    const Request _request = Request(
      RequestType.stop,
    );

    carSink.add(_request.toJsonRequest);
  }

  Future<List<Car>> get lastCars async {
    try {
      const _request = Request(RequestType.infos);
      carSink.add(_request.toJsonRequest);

      final dynamic result = await broadcastStreamController.stream.first;
      final List<dynamic>? payload = jsonDecode(result)["payload"];

      List<Car>? mappedResults = payload?.map(
        (element) {
          return Car.fromJson(element);
        },
      ).toList();

      return mappedResults ?? [];
    } catch (error) {
      throw Exception();
    }
  }

  void onClose() {
    broadcastStreamController.close();
  }
}
