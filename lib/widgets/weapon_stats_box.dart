import 'package:flutter/material.dart';

class WeaponStatsBox extends StatelessWidget {
  final String title;
  final String data;
  final String unit;

  const WeaponStatsBox({ 
    required this.title,
    required this.data,
    required this.unit,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top : 10, bottom : 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white)
      ),
      width: (width - 50)/2,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            unit,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),
        ]
      ),
    );
  }
}