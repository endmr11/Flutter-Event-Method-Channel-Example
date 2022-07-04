import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_method_channel_example/event_method_channel_example.dart';

void main() {
  const MethodChannel channel = MethodChannel('event_method_channel_example');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await EventMethodChannelExample.platformVersion, '42');
  });
}
