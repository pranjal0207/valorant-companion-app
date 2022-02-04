import 'package:flutter/material.dart';

class AgentAbilityData extends StatelessWidget {
  final String abilityIcon;
  final String abilityName;
  final String abilityData;

  const AgentAbilityData({ 
    required this.abilityIcon,
    required this.abilityName,
    required this.abilityData,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left : 15, right: 15, top: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                abilityIcon,
                width: 40
              ),

              const SizedBox(
                width: 15,
              ),

              Text(
                abilityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Valorant'
                ),
              )
            ],
          )
        ),

        Container(
          margin: const EdgeInsets.only(left : 15, right: 15, top: 20),
          child: Text(
            abilityData,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}