
import 'dart:async';

import 'package:flutter/services.dart';

class EventMethodChannelExample {
  static const MethodChannel _channel = MethodChannel('example_method_channel');
  static const EventChannel _randomDataChannel =  EventChannel('example_event_channel');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Stream<dynamic> get getRandomDataStream {
    return _randomDataChannel.receiveBroadcastStream().cast();
  }
}
