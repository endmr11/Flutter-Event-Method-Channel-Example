import 'dart:async';

import 'package:event_method_channel_example/event_method_channel_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await EventMethodChannelExample.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            StreamBuilder<dynamic>(
              stream: EventMethodChannelExample.getRandomDataStream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  return Text("Veri: ${snapshot.data}");
                } else {
                  return const Text("Yükleniyor...");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
