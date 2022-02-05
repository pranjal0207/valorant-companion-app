import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_companion/widgets/weapon_tile.dart';
import '../../models/weapons/weapon_list_item.dart';
import '../../utils/api_handler.dart';

class AllWeapons extends StatefulWidget {
  const AllWeapons({ Key? key }) : super(key: key);

  @override
  _AllWeaponsState createState() => _AllWeaponsState();
}

class _AllWeaponsState extends State<AllWeapons> {
  final apiHandler = APIHandler();

  List<WeapontListItem> weapons = [];

  List<String> weaponCategory = ["All Weapons", "Pistols", "Shotguns", "Rifles", "Sniper Rifles", "Heavy Weapons"];
  String currentCategory = "All Weapons";
  int currentCategoryIndex = 0;

  void getWeapons(int index) async{
    var temp = await apiHandler.getAllWeapons(weaponCategory[index]);

    setState(() {
      weapons = temp;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getWeapons(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.only(left : 25, right: 20),
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "ARSENAL",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Valorant'
                      ),
                    ),

                    DropdownButton(
                      //isExpanded: true,
                      value: currentCategory,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          currentCategory = newValue!;
                          currentCategoryIndex = weaponCategory.indexOf(newValue);
                        });
                        getWeapons(currentCategoryIndex);
                      },
                      items: weaponCategory.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Valorant'
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                )
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: weapons.length * 100,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: weapons.length,
                  itemBuilder: (context, index){
                    return WeaponTile(weapons: weapons[index]);
                  }
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )
    );
  }
}