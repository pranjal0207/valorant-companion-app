import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_companion/models/weapons/weapon_list_item.dart';
import 'package:valorant_companion/screens/weapons/weapon_details.dart';
import 'package:valorant_companion/utils/api_handler.dart';

class AllWeapons extends StatefulWidget {
  const AllWeapons({ Key? key }) : super(key: key);

  @override
  _AllWeaponsState createState() => _AllWeaponsState();
}

class _AllWeaponsState extends State<AllWeapons> {
  final apiHandler = APIHandler();

  List<WeapontListItem> weapons = [];

  void getWeapons() async{
    var temp = await apiHandler.getAllWeapons();

    setState(() {
      weapons = temp;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getWeapons();
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
                child : const Text(
                  "ARSENAL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Valorant'
                  ),
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
                    return GestureDetector(
                      onTap: (){
                        String id = weapons[index].id;
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeaponDetails(id: id)));
                      },
                      child: Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              weapons[index].icon,
                              height: 90,
                              width: 100,
                            ),

                            const SizedBox(
                              width: 40,
                            ),

                            Expanded(
                              child: Text(
                                weapons[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Valorant'
                                ),
                              ),
                            ),

                            if(weapons[index].id != "2f59173c-4bed-b6c3-2191-dea9b58be9c7")
                            IconButton(
                              onPressed: () {
                                String id = weapons[index].id;
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeaponDetails(id: id)));
                              },
                              icon: const Icon(Icons.arrow_forward_ios)
                            ),
                          ],
                        ),
                      )
                    );
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