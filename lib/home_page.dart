import 'package:flutter/material.dart';
import 'package:gexton_torch_app/clap_flashlight.dart';
import 'package:torch_light/torch_light.dart';

import 'blink_flashlight.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
        title: const Text(
          "Flashlight App",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
          // padding: EdgeInsets.only(top: 50, bottom: 50),
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black),
              onPressed: () {
                _normalFlashDialog();
              },
              child: Text(
                'Normal Flashight',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlinkFlashScreen()));
              },
              child: Text(
                'Blink Flashight',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClapScreen()));
              },
              child: Text(
                'Claps Flashight',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _normalFlashDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("NormaL Flashlight "),
            actions: [
              TextButton(
                child: Text(
                  "Flash On",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
                onPressed: () {
                  torchLightOn();
                },
              ),
              TextButton(
                child: Text("Flash Off",
                    style: TextStyle(color: Colors.red, fontSize: 18)),
                onPressed: () {
                  torchLightOff();
                },
              )
            ],
          );
        });
  }

  Future<void> torchLightOn() async {
    try {
      await TorchLight.enableTorch();
    } on EnableTorchExistentUserException catch (e) {
      //camera in use
      print("camera in use");
    } on EnableTorchNotAvailableException catch (e) {
      //torch not available
      print("torch not available");
    } on EnableTorchException catch (e) {
      //something went wrong
      print("something went wrong");
    }
  }

  Future<void> torchLightOff() async {
    try {
      await TorchLight.disableTorch();
    } on DisableTorchExistentUserException catch (e) {
      //camera in use
      print("camera in use");
    } on DisableTorchNotAvailableException catch (e) {
      //torch not available
      print("torch not available");
    } on DisableTorchException catch (e) {
      //something went wrong
      print("something went wrong");
    }
  }
}
