import 'package:flutter/material.dart';
import '../models/weapons/weapon_skins.dart';

class WeaponSkinItemBox extends StatelessWidget {
  final WeaponSkins skin;

  const WeaponSkinItemBox({ 
    required this.skin,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.only(top : 20, bottom : 20, left : 10, right : 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white)
        ),
        height: 182,
        width: (width - 50)/2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              skin.name,
              style: const TextStyle(
                fontFamily: 'Valorant'
              )
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.network(
                    skin.displayImage,
                    height: 60
                  ),
                ],
              )
            )
            
          ],
        ),
      );
  }
}