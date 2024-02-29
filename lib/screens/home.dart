import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('services.kth.dev/logs');
  String _startServiceStatus = 'Unknown.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _startService,
              child: const Text('Start Service'),
            ),
            Text(_startServiceStatus),
          ],
        ),
      ),
    );
  }

  Future<void> _startService() async {
    String status;
    try {
      final result = await platform.invokeMethod<int>('start_service');
      status = '$result';
    } on PlatformException catch (e) {
      status = "Failed to start service: '${e.message}'.";
    }

    setState(() {
      _startServiceStatus = status;
    });
  }
}
