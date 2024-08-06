import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.flutter/flashlight');
  bool _isFlashlightOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      final bool result = await platform.invokeMethod('toggleFlashlight');
      setState(() {
        _isFlashlightOn = result;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flashlight Control'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                size: 100,
                color: _isFlashlightOn ? Colors.yellow : Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                _isFlashlightOn ? 'Flashlight On' : 'Flashlight Off',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _toggleFlashlight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    _isFlashlightOn ? 'Turn Off' : 'Turn On',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
