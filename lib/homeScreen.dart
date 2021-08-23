import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int ld = 1;
  int rd = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          ld = Random().nextInt(6) + 1;
          rd = Random().nextInt(6) + 1;
        });

        print("Completed");
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dicee"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage("assets/image/dice-png-$ld.png")),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage("assets/image/dice-png-$rd.png")),
                  ),
                )),
              ],
            ),
            RaisedButton(
              onPressed: roll,
              child: Text(
                "Roll",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
