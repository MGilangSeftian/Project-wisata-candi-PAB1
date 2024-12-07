import 'package:flutter/material.dart';

class AnimatedCrossFadeWidget extends StatefulWidget {
  const AnimatedCrossFadeWidget({super.key});

  @override
  State<AnimatedCrossFadeWidget> createState() => _AnimatedCrossFadeWidgetsState();
}

class _AnimatedCrossFadeWidgetsState extends State<AnimatedCrossFadeWidget> {
  bool _croosFdeStateShowFirst = true;
  
  void _crossFade (){
    setState(() {
      _croosFdeStateShowFirst = _croosFdeStateShowFirst ? false : true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget> [
        AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        sizeCurve: Curves.bounceOut,
        crossFadeState: _croosFdeStateShowFirst
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Container(
          color: Colors.yellow,
          height: 100.0,
          width: 100.0,
        ),
        secondChild: Container(
          color: Colors.lime,
          height: 200.0,
          width: 200.0,
        ),
        ),
            Positioned.fill(
              child: TextButton(
                child: const Text('Tap to\nFade Color & Size'),
                onPressed: () {
                  _crossFade();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
