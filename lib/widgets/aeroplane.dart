import 'package:flutter/material.dart';

class Aeroplane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32,
      left: 40,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.airplanemode_active,
          color: Colors.white,
          size: 64,
        ),
      ),
    );
  }
}
