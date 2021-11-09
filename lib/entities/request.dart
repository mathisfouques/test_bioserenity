import 'dart:convert';

import 'package:flutter/foundation.dart';

enum RequestType {
  infos,
  stop,
  start,
}

class Request {
  const Request(this.requestType, {this.accessToken = 42, this.payload});

  final RequestType requestType;
  final int accessToken;
  final Map<String, Object>? payload;

  String get toJsonRequest {
    final map = {
      "type": describeEnum(requestType),
      "user": accessToken,
      if (payload != null) "payload": payload,
    };

    return jsonEncode(map);
  }
}
