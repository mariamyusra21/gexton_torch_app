import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class BlinkFlashScreen extends StatefulWidget {
  @override
  _BlinkFlashScreenState createState() => _BlinkFlashScreenState();
}

class _BlinkFlashScreenState extends State<BlinkFlashScreen> {
  bool _isOn = false;
  int _interval = 100;
  double _intensity = 1.0;

  @override
  void initState() {
    super.initState();
    TorchLight.isTorchAvailable().then((hasTorch) {
      if (!hasTorch) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Flashlight Available'),
              content: Text('This device does not have a flashlight.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _toggleFlashlight() {
    setState(() {
      _isOn = !_isOn;
    });

    if (_isOn) {
      TorchLight.enableTorch();
      _startBlinking();
    } else {
      TorchLight.disableTorch();
    }
  }

  void _startBlinking() {
    Future.delayed(Duration(milliseconds: _interval), () {
      if (_isOn) {
        TorchLight.disableTorch();
        Future.delayed(Duration(milliseconds: (_interval * _intensity).round()),
            () {
          if (_isOn) {
            TorchLight.enableTorch();
            _startBlinking();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
        title: Text(
          'Blink Flashlight',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flashlight Status: ${_isOn ? 'ON' : 'OFF'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Blink Interval (ms):',
              style:
                  TextStyle(fontSize: 16, backgroundColor: Colors.amberAccent),
            ),
            Slider(
              value: _interval.toDouble(),
              min: 100,
              max: 2000,
              divisions: 20,
              activeColor: Colors.amberAccent,
              inactiveColor: Colors.black,
              onChanged: (double value) {
                setState(() {
                  _interval = value.toInt();
                });
              },
            ),
            Text(
              'Blink Intensity:',
              style:
                  TextStyle(fontSize: 16, backgroundColor: Colors.amberAccent),
            ),
            Slider(
              value: _intensity.toDouble(),
              min: 0.1,
              max: 1.0,
              divisions: 9,
              activeColor: Colors.amberAccent,
              inactiveColor: Colors.black,
              onChanged: (double value) {
                setState(() {
                  _intensity = value;
                });
              },
            ),
            TextButton(
              onPressed: _toggleFlashlight,
              child: Text(
                _isOn ? 'Turn Off' : 'Turn On',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  backgroundColor: Colors.amberAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
