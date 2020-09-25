import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      bottom: 12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_downward),
              color: Color.fromRGBO(120, 58, 183, 1),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
