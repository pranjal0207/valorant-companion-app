import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../screens/weapons/weapon_details.dart';
import '../models/weapons/weapon_list_item.dart';

class WeaponTile extends StatelessWidget {
  final WeapontListItem weapons;

  const WeaponTile({ 
    required this.weapons,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        String id = weapons.id;
        if(weapons.id != "2f59173c-4bed-b6c3-2191-dea9b58be9c7") {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeaponDetails(id: id)));
        }
      },
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl : weapons.icon,
              height: 90,
              width: 100,
            ),

            const SizedBox(
              width: 40,
            ),

            Expanded(
              child: Text(
                weapons.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Valorant'
                ),
              ),
            ),

            if(weapons.id != "2f59173c-4bed-b6c3-2191-dea9b58be9c7")
            IconButton(
              onPressed: () {
                String id = weapons.id;
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeaponDetails(id: id)));
              },
              icon: const Icon(Icons.arrow_forward_ios)
            ),
          ],
        ),
      )
    );
  }
}