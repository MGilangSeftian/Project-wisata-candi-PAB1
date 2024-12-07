import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const  AnimatedContainerWidget({super.key});

  @override
  State< AnimatedContainerWidget> createState() => _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State< AnimatedContainerWidget> {
  final double _height = 100.0;
  double _width = 100.0;

  void _increaseWidth(){
    setState(() {
      _width = _height >=350.0 ? 100.0 : _width +=50.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticInOut,
          color: Colors.yellow,
          height: _height,
          width: _width,
          child: TextButton(
              onPressed: (){
                _increaseWidth();
              },
              child: Text('Tap to \nGrow width\n$_width'),
          ),
        )
      ],
    );
  }
}
