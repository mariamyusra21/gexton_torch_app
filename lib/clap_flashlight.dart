import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class ClapScreen extends StatefulWidget {
  @override
  _ClapScreenState createState() => _ClapScreenState();
}

class _ClapScreenState extends State<ClapScreen> {
  bool _isFlashlightOn = false;
  int _clapCount = 0;

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

  @override
  void dispose() {
    TorchLight.disableTorch();
    super.dispose();
  }

  void _onClapDetected() {
    setState(() {
      _clapCount++;

      if (_clapCount == 2 && !_isFlashlightOn) {
        TorchLight.enableTorch();
        _isFlashlightOn = true;
      } else if (_clapCount == 4 && _isFlashlightOn) {
        TorchLight.disableTorch();
        _isFlashlightOn = false;
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
          'Clap Flashlight',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onClapDetected,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Clap Count: $_clapCount',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Flashlight Status: ${_isFlashlightOn ? 'ON' : 'OFF'}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
