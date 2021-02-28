import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color color;
  final double thickness;

  const OrDivider({
    Key key,
    this.color = Colors.black38,
    this.thickness = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              'OR',
              style: TextStyle(
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
